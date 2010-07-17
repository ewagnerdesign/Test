class AddNotesToSiteVisit < ActiveRecord::Migration
  def self.up
    add_column :sites_visits, :notes, :string, :limit => 45
  end

  def self.down
    remove_column :sites_visits, :notes
  end
end
