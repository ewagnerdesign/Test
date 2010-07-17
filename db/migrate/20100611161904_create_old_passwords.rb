require "migration_helper"

class CreateOldPasswords < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    create_table :old_passwords do |t|
      t.string :crypted_password, :limit => 255, :null => false
      t.string :password_salt, :limit => 255, :null => false
      t.references :user, :null => false

      t.timestamps
    end
    add_index :old_passwords, [:user_id], :unique => false
    add_foreign_key :old_passwords, :user_id, :users
  end

  def self.down
    remove_foreign_key :old_passwords, :user_id
    drop_table :old_passwords
  end
end
