require "migration_helper"

class StudyUsersUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    add_index :study_users, [:study_id, :user_id], :unique => true
    add_foreign_key :study_users, :study_id, :studies
    add_foreign_key :study_users, :user_id, :users
  end

  def self.down
    remove_foreign_key :study_users, :user_id
    remove_foreign_key :study_users, :study_id
    remove_index :study_users, [:study_id, :user_id]
  end
end
