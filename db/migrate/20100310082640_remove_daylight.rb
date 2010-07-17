class RemoveDaylight < ActiveRecord::Migration
  def self.up
    remove_column :sites, :daylight
  end

  def self.down
    add_column :sites, :daylight, :boolean 
  end
end
