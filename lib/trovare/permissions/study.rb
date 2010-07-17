module Trovare
  module Permissions

    module Study
      class << self
        def get_permissions(user_id)
          permissions = {:study => {}, :site => []}
          study_user = StudyUser.find(:all, :conditions => {:user_id => user_id.to_i})
          if study_user.count > 0
            study_user.each do |su|
              permissions[:study][su.id] = su.roles || []
              permissions[:site] << su.sites.map(&:id) if su.sites.count > 0
            end
            permissions
          else
            []
          end
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
        base.class_eval do
          attr_accessor :permissions
        end
        base.send :include, InstanceMethods
      end # self.included

      module ClassMethods
      end # ClassMethods

      module InstanceMethods
        #private
        def populate_studies
          @permissions = []
          su = StudyUser.find(:all, :conditions => {:user_id => self.id})
          su.each do |assign|
            @permissions[assign.study_id] = assign.roles
          end
        end
      end # InstanceMethods

    end #Study
  end #Permissions
end #Trovare
