require "migration_helper"

class SubjectsUpdate1 < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    change_column :subjects, :gender, "ENUM('F', 'M') ", :null => false
    change_column :subjects, :inactive, :boolean, :null => false, :default => false
  end

  def self.down
    change_column :subjects, :gender, :string, :limit => 1, :null => false
    change_column :subjects, :inactive, :boolean, :null => false
  end
end
