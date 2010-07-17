class AddFirstLoginToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_login, :boolean, :default=>true
  end

  def self.down
    remove_column :users, :first_login
  end
end
