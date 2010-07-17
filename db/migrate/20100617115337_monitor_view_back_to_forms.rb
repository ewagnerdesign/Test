require "migration_helper"

class MonitorViewBackToForms < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    remove_foreign_key :monitor_views, :form_version_id
    remove_column :monitor_views, :form_version_id
    add_column :monitor_views, :form_id, :integer, :null => false
    add_foreign_key :monitor_views, :form_id, :forms
  end

  def self.down
    remove_foreign_key :monitor_views, :form_id
    remove_column :monitor_views, :form_id
    add_column :monitor_views, :form_version_id, :integer, :null => false
    add_foreign_key :monitor_views, :form_version_id, :form_versions
  end
end
