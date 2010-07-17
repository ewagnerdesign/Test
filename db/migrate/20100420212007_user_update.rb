class UserUpdate < ActiveRecord::Migration
  def self.up
    change_column :users, :address_1, :string, :limit => 255, :null => false
    change_column :users, :login, :string, :limit => 255, :null => true
    change_column :users, :crypted_password, :string, :limit => 255, :null => true
    change_column :users, :password_salt, :string, :limit => 255, :null => true
    change_column :users, :current_login_ip, :string, :limit => 15, :null => true
    change_column :users, :last_login_ip, :string, :limit => 15, :null => true
  end

  def self.down
    change_column :users, :address_1, :string, :limit => 255, :null => true
    change_column :users, :login, :string, :limit => 255, :null => false
    change_column :users, :crypted_password, :string, :limit => 255, :null => false
    change_column :users, :password_salt, :string, :limit => 255, :null => false
    change_column :users, :current_login_ip, :string, :limit => 255, :null => true
    change_column :users, :last_login_ip, :string, :limit => 255, :null => true
  end
end
