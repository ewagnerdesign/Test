class AddTimeZoneToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :time_zone, :string # TZInfo
    add_column :sites, :daylight, :boolean
  end

  def self.down
    remove_column :sites, :time_zone
    remove_column :sites, :daylight
  end
end
