module ActiveRecord
  module Validations

    VALIDATION_INIT_OPTIONS = {
      :validMessage => "",
      :skipOnSubmit => true
    }

    NEW_VALIDATION_METHODS = {
      :presence => "Validate.Presence",
      :numericality => "Validate.Numericality",
      :format => "Validate.Format",
      :length => "Validate.Length",
      :acceptance => "Validate.Acceptance",
      :confirmation => "Validate.Confirmation",
      :inclusion => "Validate.Interval"
    }

    ADDED_VALIDATION_METHODS = {
      :inclusion => "Validate.Interval"
    }


    module ClassMethods
      ADDED_VALIDATION_METHODS.keys.each do |type|
        define_method "validates_#{type}_of_with_live_validations".to_sym do |*attr_names|
          send "validates_#{type}_of_without_live_validations".to_sym, *attr_names
          define_validations(type, attr_names)
        end
        alias_method_chain "validates_#{type}_of".to_sym, :live_validations
      end

      private

      def map_configuration(configuration, type = nil, attr_name = '')
        LIVE_VALIDATIONS_OPTIONS.each do |live, rails|
          configuration[live] = configuration.delete(rails)
        end
        if type == :numericality
          if configuration[:onlyInteger]
            configuration[:notAnIntegerMessage] = configuration.delete(:failureMessage)
          else
            configuration[:notANumberMessage] = configuration.delete(:failureMessage)
          end

          if configuration[:greater_than_or_equal_to]
            configuration[:minimum] = configuration.delete(:greater_than_or_equal_to)
          end

          if configuration[:less_than_or_equal_to]
            configuration[:maximum] = configuration.delete(:less_than_or_equal_to)
          end

        end
        if type == :inclusion
          range = configuration.delete(:in)
          if range == [false, true] # for boolean fields, like validates_inclusion_of :active, :in => [false, true]
            configuration[:minimum] = false
            configuration[:maximum] = true
          else
            configuration[:minimum] = range.begin
            configuration[:maximum] = range.end
          end
        end
        if type == :length and range = ( configuration.delete(:in) || configuration.delete(:within) )
          configuration[:minimum] = range.begin
          configuration[:maximum] = range.end
        end
        if type == :confirmation
          configuration[:match] = self.to_s.underscore + '_' + attr_name.to_s + '_confirmation'
        end
        configuration[:validMessage] ||= ''
        configuration.reject {|k, v| v.nil? }
      end

    end
  end
end
