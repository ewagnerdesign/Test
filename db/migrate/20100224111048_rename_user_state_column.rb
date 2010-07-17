class RenameUserStateColumn < ActiveRecord::Migration
  def self.up
    rename_column :users, :state, :state_cd
  end

  def self.down
    rename_column :users, :state_cd, :state
  end
end
