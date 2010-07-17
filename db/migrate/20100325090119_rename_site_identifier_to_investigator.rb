class RenameSiteIdentifierToInvestigator < ActiveRecord::Migration
  def self.up
    rename_column :sites, :identifier, :investigator
  end

  def self.down
    rename_column :sites, :investigator, :identifier
  end
end
