require "migration_helper"

class CreateSecurityTables < ActiveRecord::Migration
  extend MigrationHelper
  
  def self.up
    create_table :permissions do |t|
      t.string :name, :limit => 45, :null => false
      t.string :description, :limit => 255, :null => false
      t.integer :category, :null => false

      t.timestamps
    end
    add_index :permissions, :name, :unique => true

    create_table :roles do |t|
      t.string :name, :limit => 45, :null => false
      t.string :description, :limit => 255, :null => false
      t.integer :category, :null => false

      t.timestamps
    end
    add_index :roles, [:name], :unique => true

    create_table :permission_roles do |t|
      t.references :permission, :null => false
      t.references :role, :null => false

      t.timestamps
    end
    add_foreign_key :permission_roles, :permission_id, :permissions
    add_foreign_key :permission_roles, :role_id, :roles
    add_index :permission_roles, [:permission_id, :role_id], :unique => true

    create_table :role_users do |t|
      t.references :role, :null => false
      t.references :user, :null => false

      t.timestamps
    end
    add_foreign_key :role_users, :role_id, :roles
    add_foreign_key :role_users, :user_id, :users
    add_index :role_users, [:role_id, :user_id], :unique => true

    create_table :role_study_users do |t|
      t.references :role, :null => false
      t.references :study_user, :null => false

      t.timestamps
    end
    add_foreign_key :role_study_users, :role_id, :roles
    add_foreign_key :role_study_users, :study_user_id, :study_users
    add_index :role_study_users, [:role_id, :study_user_id], :unique => true

    create_table :role_site_users do |t|
      t.references :role, :null => false
      t.references :site_user, :null => false

      t.timestamps
    end
    add_foreign_key :role_site_users, :role_id, :roles
    add_foreign_key :role_site_users, :site_user_id, :users
    add_index :role_site_users, [:role_id, :site_user_id], :unique => true

    add_column :users, :site_user, :boolean, :null => false, :default => true 

    create_table :site_study_users do |t|
      t.references :study_user, :null => false
      t.references :site, :null => false

      t.timestamps
    end
    add_foreign_key :site_study_users, :site_id, :sites
    add_foreign_key :site_study_users, :study_user_id, :users
    add_index :site_study_users, [:site_id, :study_user_id], :unique => true

    remove_foreign_key :study_site_users, :site_user_id
    remove_foreign_key :study_site_users, :study_id
    remove_index :study_site_users, [:study_id, :site_user_id]
    drop_table :study_site_users
  end

  def self.down
    create_table :study_site_users do |t|
      t.references :study, :null => false
      t.references :site_user, :null => false

      t.timestamps
    end
    add_foreign_key :study_site_users, :study_id, :sites
    add_foreign_key :study_site_users, :site_user_id, :users
    add_index :study_site_users, [:study_id, :site_user_id], :unique => true

    remove_foreign_key :site_study_users, :site_id
    remove_foreign_key :site_study_users, :study_user_id
    drop_table :site_study_users

    remove_column :users, :site_user

    remove_foreign_key :role_site_users, :role_id
    remove_foreign_key :role_site_users, :site_user_id
    drop_table :role_site_users

    remove_foreign_key :role_study_users, :role_id
    remove_foreign_key :role_study_users, :study_user_id
    drop_table :role_study_users

    remove_foreign_key :role_users, :role_id
    remove_foreign_key :role_users, :user_id
    drop_table :role_users

    remove_foreign_key :permission_roles, :permission_id
    remove_foreign_key :permission_roles, :role_id
    drop_table :permission_roles

    drop_table :roles
    drop_table :permissions
  end
end
