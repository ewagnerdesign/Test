require "migration_helper"

class CreateStudySiteFormVersions < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    create_table :study_site_form_versions do |t|
      t.boolean :accepted, :null => false, :default => false
      t.belongs_to :study_site, :null => false
      t.belongs_to :form_version, :null => false

      t.timestamps
    end

    add_foreign_key :study_site_form_versions, :study_site_id, :study_sites
    add_foreign_key :study_site_form_versions, :form_version_id, :form_versions
    add_index :study_site_form_versions, [:study_site_id, :form_version_id], :name => 'study_site_form_versions_assocs', :unique => true
  end

  def self.down
    remove_foreign_key :study_site_form_versions, :study_site_id
    remove_foreign_key :study_site_form_versions, :form_version_id

    drop_table :study_site_form_versions
  end
end
