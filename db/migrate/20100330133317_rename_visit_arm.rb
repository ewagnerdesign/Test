require "migration_helper"

class RenameVisitArm < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    remove_foreign_key :visit_arms, :study_id
    rename_table :visit_arms, :study_arms
    add_foreign_key :study_arms, :study_id, :studies
  end

  def self.down
    remove_foreign_key :study_arms, :study_id
    rename_table :study_arms, :visit_arms
    add_foreign_key :visit_arms, :study_id, :studies
  end
end
