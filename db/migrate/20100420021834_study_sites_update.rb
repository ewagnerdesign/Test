require "migration_helper"

class StudySitesUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    add_index :study_sites, [:study_id, :site_id], :unique => true
    add_foreign_key :study_sites, :study_id, :studies
    add_foreign_key :study_sites, :site_id, :sites
  end

  def self.down
    remove_foreign_key :study_sites, :site_id
    remove_foreign_key :study_sites, :study_id
    remove_index :study_sites, [:study_id, :site_id]
  end
end
