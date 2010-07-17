require "migration_helper"

class CreateFormStudyArmVisits < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    create_table :form_study_arm_visits do |t|
      t.belongs_to :form, :null => false
      t.belongs_to :study_arm_visit, :null => false

      t.timestamps
    end

    add_index :form_study_arm_visits, [:form_id, :study_arm_visit_id], :unique => true

    add_foreign_key :form_study_arm_visits, :form_id, :forms
    add_foreign_key :form_study_arm_visits, :study_arm_visit_id, :study_arm_visits

    drop_table :form_visits
  end

  def self.down
    remove_foreign_key :form_study_arm_visits, :form_id
    remove_foreign_key :form_study_arm_visits, :study_arm_visit_id

    drop_table :form_study_arm_visits

    create_table "form_visits", :force => true do |t|
      t.integer "form_id",  :null => false
      t.integer "visit_id", :null => false
    end
  end
end
