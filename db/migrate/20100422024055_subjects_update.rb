require "migration_helper"

class SubjectsUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    add_index :subjects, [:study_id, :code], :unique => true
    change_column :subjects, :study_arm_id, :integer, :null => false
    add_foreign_key :subjects, :study_id, :studies
    add_foreign_key :subjects, :study_arm_id, :study_arms
  end

  def self.down
    remove_foreign_key :subjects, :study_arm_id
    remove_foreign_key :subjects, :study_id
    remove_index :subjects, [:study_id, :code]
    change_column :subjects, :study_arm_id, :integer, :null => true
  end
end
