class AddLockVersionToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :lock_version, :integer
  end

  def self.down
    remove_column :sites, :lock_version
  end
end
