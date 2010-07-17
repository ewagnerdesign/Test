module Trovare
  module Permissions
    module Site
      class << self
        def get_permissions(user_id)
          permissions = {:study =>{}, :site =>[]}
          site_user = SiteUser.find(:first, :conditions => {:user_id => user_id.to_i})
          if site_user
            permissions[:site] = site_user.roles
            #Get study assigns
            site_user.study_site_users.each do |ssu|
              permissions[:study][ssu.study_id] = ssu.roles
            end
          end
          permissions
        end
      end #Class
    end #Site
  end #Permissions
end #Trovare
