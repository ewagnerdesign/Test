class FixPermissionName < ActiveRecord::Migration
  def self.up
    change_column :permissions, :name, :string, :null => false, :limit => 100
  end

  def self.down
    change_column :permissions, :name, :string, :null => false, :limit => 45
  end
end
