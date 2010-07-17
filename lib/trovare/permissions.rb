module Trovare
  module Permissions
    mattr_accessor :roles
    class << self
      def can?(study, site)
        case @roles.kind_of?
          when Trovare::Permissions::Study
            if
                #Mo access if study not given
                study.nil? ||
                #No access if user is not assigned to the study
                !@roles[:study].keys.include?(study) then
              false
            else
              #No site provided, so just study role required
              if site.nil?
                true
              else
                #There are some sites provided
                #Empty list means that we have access to all sites
                @roles[:site].count == 0 || @roles[:site].include?(site)
              end
            end
          when Trovare::Permissions::Site
            raise "Permissions for site is not implemented"
        end
      end
    end
  end #Permissions
end #Trovare
