class RemoveStudyAndSiteAssociations < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    remove_foreign_key(:sites, :study_id)
    remove_column :sites, :study_id
  end

  def self.down
    add_column :sites, :study_id, :integer
    add_foreign_key(:sites, :study_id, :studies)
  end
end
