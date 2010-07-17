require "migration_helper"
class CreateVisitArms < ActiveRecord::Migration
  extend MigrationHelper
  
  def self.up
    create_table :visit_arms do |t|
      t.string :code, :null => false, :limit => 45
      t.boolean :default, :null => false
      t.integer :study_id, :null => false

      t.timestamps
    end
    add_foreign_key :visit_arms, :study_id, :studies
  end

  def self.down
    remove_foreign_key :visit_arms, :study_id
    drop_table :visit_arms
  end
end