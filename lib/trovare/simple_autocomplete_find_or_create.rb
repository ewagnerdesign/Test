# -*- coding: utf-8 -*-
# Store the value of the autocomplete field as association
# autocomplete_for('user','name')
# -> the auto_user_name field will be resolved to a User, using User.find_by_autocomplete_name(value)
# -> Post has autocomplete_for('user','name')
# -> User has find_by_autocomplete('name')
class ActiveRecord::Base
  def self.autocomplete_for(model, attribute, options={})
    name = options[:name] || model.to_s.underscore
    name = name.to_s
    model = model.to_s.camelize.constantize

    # is the correct finder defined <-> warn users
    or_create = "or_create_" if options[:create]
    finder = "find_#{or_create}by_autocomplete_#{attribute}"

    unless model.respond_to? finder
      raise "#{model} does not respond to #{finder}, maybe you forgot to add auto_complete_for(:#{attribute}) to #{model}?"
    end

    #auto_user_name= "Hans"
    define_method "auto_#{name}_#{attribute}=" do |value|
      send "#{name}=", model.send(finder, value)
    end

    #auto_user_name
    define_method "auto_#{name}_#{attribute}" do
      send(name).try(:send, attribute).to_s
    end
  end

  def self.find_or_create_by_autocomplete(attr)
    metaclass = (class << self; self; end)
    metaclass.send(:define_method, "find_or_create_by_autocomplete_#{attr}") do |value|
      return if value.blank?
      self.first(:conditions => [ "LOWER(#{attr}) = ?", value.to_s.downcase ]) || self.create(attr.to_sym => value)
    end
  end
end
