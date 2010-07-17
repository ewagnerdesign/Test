require "migration_helper"

class CreateLoginAttempts < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    create_table :login_attempts do |t|
      t.string     :login,            :null => false
      t.belongs_to :user
      t.string     :ip, :limit => 15, :null => false
      t.string     :user_agent,       :null => false

      t.timestamps
    end

    add_foreign_key :login_attempts, :user_id, :users
  end

  def self.down
    remove_foreign_key :login_attempts, :user_id
    drop_table :login_attempts
  end
end
