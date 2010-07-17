require "migration_helper" 

class FixSiteStudyUsersForeignKey < ActiveRecord::Migration
  extend MigrationHelper
  
  def self.up
    remove_foreign_key :site_study_users, :study_user_id
    add_foreign_key :site_study_users, :study_user_id, :study_users
  end

  def self.down
  end
end
