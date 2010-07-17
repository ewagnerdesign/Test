require "migration_helper"

class SiteUsersUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    add_index :site_users, [:site_id, :user_id], :unique => true
    add_foreign_key :site_users, :site_id, :sites
    add_foreign_key :site_users, :user_id, :users
  end

  def self.down
    remove_foreign_key :site_users, :user_id
    remove_foreign_key :site_users, :site_id
    remove_index :site_users, [:site_id, :user_id]
  end
end
