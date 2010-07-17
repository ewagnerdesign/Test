class MakeLoginAttemptLoginNull < ActiveRecord::Migration
  def self.up
    change_column :login_attempts, :login, :string, :null => true
  end

  def self.down
    change_column :login_attempts, :login, :string, :null => false
  end
end
