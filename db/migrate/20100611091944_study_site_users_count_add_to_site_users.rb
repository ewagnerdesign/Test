class StudySiteUsersCountAddToSiteUsers < ActiveRecord::Migration
  def self.up
    add_column :site_users, :study_site_users_count,
               :integer, :default=>0, :nil=>false

    say_with_time "update site users counters" do
      SiteUser.reset_column_information
      SiteUser.all.each do |u|
        SiteUser.update_counters(
            u.id, :study_site_users_count=>u.study_site_users.count
        )
      end

    end
  end

  def self.down
    remove_column :site_users, :study_site_users_count
  end
end
