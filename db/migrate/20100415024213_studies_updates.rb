require "migration_helper"

class StudiesUpdates < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    change_column :studies, :title, :string, :limit => 255, :null => false
    add_foreign_key :studies, :therapeutic_area_id, :therapeutic_areas
  end

  def self.down
    change_column :studies, :title, :string, :limit => 255, :null=> true
    remove_foreign_key :studies, :therapeutic_area_id
  end
end
