require "migration_helper"

class AddCreatedByToFormVersion < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    add_column :form_versions, :created_by_id, :integer, :null => false
    add_foreign_key :form_versions, :created_by_id, :users
  end

  def self.down
    remove_foreign_key :form_versions, :created_by_id
    remove_column :form_versions, :created_by_id
  end
end
