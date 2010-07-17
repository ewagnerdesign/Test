require "migration_helper"

class VisitsUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    add_index :visits, [:study_id, :number], :unique => true
    add_index :visits, [:study_id, :name], :unique => true
    change_column :visits, :status, :string, :limit => 45, :null => true
    add_foreign_key :visits, :study_id, :studies
    add_foreign_key :visits, :prev_visit_id, :visits
  end

  def self.down
    remove_foreign_key :visits, :study_id
    remove_foreign_key :visits, :prev_visit_id
    remove_index :visits, [:study_id, :number]
    remove_index :visits, [:study_id, :name]
    change_column :visits, :status, :string, :limit => 255, :null => true
  end
end
