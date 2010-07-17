require "migration_helper"

class StudyArmVisitsUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    add_index :study_arm_visits, [:study_arm_id, :visit_id], :unique => true
    add_foreign_key :study_arm_visits, :study_arm_id, :study_arms
    add_foreign_key :study_arm_visits, :visit_id, :visits
  end

  def self.down
    remove_foreign_key :study_arm_visits, :visit_id
    remove_foreign_key :study_arm_visits, :study_arm_id
    remove_index :study_arm_visits, [:study_arm_id, :visit_id]
  end
end
