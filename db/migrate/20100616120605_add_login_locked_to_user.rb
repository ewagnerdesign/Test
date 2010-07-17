class AddLoginLockedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :login_locked, :datetime, :null => true
  end

  def self.down
    remove_column :users, :login_locked
  end
end
