class AddVisibleToAudit < ActiveRecord::Migration
  def self.up
    add_column :changes_history, :visible, :boolean, :null => false, :default => true
  end

  def self.down
    remove_column :changes_history, :visible
  end
end
