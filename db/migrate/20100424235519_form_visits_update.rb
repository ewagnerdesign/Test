require "migration_helper"

class FormVisitsUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    change_column :form_visits, :form_id, :integer, :null => false
    change_column :form_visits, :visit_id, :integer, :null => false
    add_index :form_visits, [:form_id, :visit_id], :unique => true
    add_foreign_key :form_visits, :form_id, :forms
    add_foreign_key :form_visits, :visit_id, :visits
  end

  def self.down
    remove_foreign_key :form_visits, :visit_id
    remove_foreign_key :form_visits, :form_id
    remove_index :form_visits, [:form_id, :visit_id]
    change_column :form_visits, :form_id, :integer, :null => true
    change_column :form_visits, :visit_id, :integer, :null => true
  end
end
