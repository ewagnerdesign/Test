require "migration_helper"

class StudyFormOptions < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    change_column :study_forms, :study_id, :integer, :null => false
    change_column :study_forms, :form_id, :integer, :null => false

    add_index :study_forms, [:form_id, :study_id], :unique => true

    add_foreign_key :study_forms, :form_id, :forms
    add_foreign_key :study_forms, :study_id, :studies
  end

  def self.down
    remove_foreign_key :study_forms, :form_id
    remove_foreign_key :study_forms, :study_id
  end
end
