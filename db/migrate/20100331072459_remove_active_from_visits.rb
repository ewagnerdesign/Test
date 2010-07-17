class RemoveActiveFromVisits < ActiveRecord::Migration
  def self.up
    remove_column :visits, :active
  end

  def self.down
    add_column :visits, :active, :boolean, :null => false
  end
end
