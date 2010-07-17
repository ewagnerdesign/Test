require "migration_helper"

class StudySiteUsersUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    add_index :study_site_users, [:study_id, :site_user_id], :unique => true
    add_foreign_key :study_site_users, :study_id, :studies
    add_foreign_key :study_site_users, :site_user_id, :site_users
  end

  def self.down
    remove_foreign_key :study_site_users, :site_user_id
    remove_foreign_key :study_site_users, :study_id
    remove_index :study_site_users, [:study_id, :site_user_id]
  end
end
