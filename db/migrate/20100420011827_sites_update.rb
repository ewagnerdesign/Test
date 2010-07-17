class SitesUpdate < ActiveRecord::Migration
  def self.up
    add_index :sites, :name, :unique => true
  end

  def self.down
    remove_index :sites, :name
  end
end
