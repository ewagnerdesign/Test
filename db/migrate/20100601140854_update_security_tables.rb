require "migration_helper"

class UpdateSecurityTables < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    create_table :study_site_users do |t|
      t.references :study, :null => false
      t.references :site_user, :null => false

      t.timestamps
    end
    add_foreign_key :study_site_users, :study_id, :studies
    add_foreign_key :study_site_users, :site_user_id, :site_users
    add_index :study_site_users, [:study_id, :site_user_id], :unique => true

    create_table :role_study_site_users do |t|
      t.references :role, :null => false
      t.references :study_site_user, :null => false

      t.timestamps
    end
    add_foreign_key :role_study_site_users, :role_id, :roles
    add_foreign_key :role_study_site_users, :study_site_user_id, :study_site_users
    add_index :role_study_site_users, [:role_id, :study_site_user_id], :unique => true
  end

  def self.down
    remove_foreign_key :role_study_site_users, :role_id
    remove_foreign_key :role_study_site_users, :study_site_user_id
    drop_table :role_study_site_users

    remove_foreign_key :study_site_users, :site_user_id
    remove_foreign_key :study_site_users, :study_id
    remove_index :study_site_users, [:study_id, :site_user_id]
    drop_table :study_site_users
  end
end
