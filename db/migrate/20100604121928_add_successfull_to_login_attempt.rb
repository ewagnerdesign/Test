class AddSuccessfullToLoginAttempt < ActiveRecord::Migration
  def self.up
    add_column :login_attempts, :successfull, :boolean, :null => false
  end

  def self.down
    remove_column :login_attempts, :successfull
  end
end
