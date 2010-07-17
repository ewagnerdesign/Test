require "migration_helper"

class FormVersionRelatedUpdates < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    # FormInstance
    remove_foreign_key :form_instances, :form_id
    remove_column :form_instances, :form_id
    add_column :form_instances, :form_version_id, :integer, :null => false
    add_foreign_key :form_instances, :form_version_id, :form_versions
    # FormField
    remove_column :form_fields, :form_id
    add_column :form_fields, :form_version_id, :integer, :null => false
    add_foreign_key :form_fields, :form_version_id, :form_versions
    # MonitorView
    remove_column :monitor_views, :form_id
    add_column :monitor_views, :form_version_id, :integer, :null => false
    add_foreign_key :monitor_views, :form_version_id, :form_versions
    # Form
    remove_column :forms, :metadata
    remove_column :forms, :html
  end
  
  def self.down
    # FormInstance
    remove_foreign_key :form_instances, :form_version_id
    remove_column :form_instances, :form_version_id
    add_column :form_instances, :form_id, :integer, :null => false
    add_foreign_key :form_instances, :form_id, :forms
    # FormField
    remove_foreign_key :form_fields, :form_version_id
    remove_column :form_fields, :form_version_id
    add_column :form_fields, :form_id, :integer, :null => false
    # MonitorView
    remove_foreign_key :monitor_views, :form_version_id
    remove_column :monitor_views, :form_version_id
    add_column :monitor_views, :form_id, :integer, :null => false
    # Form
    add_column :forms, :metadata, :text, :null => false
    add_column :forms, :html, :text
  end
end
