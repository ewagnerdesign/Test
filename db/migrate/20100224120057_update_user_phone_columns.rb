class UpdateUserPhoneColumns < ActiveRecord::Migration
  def self.up
    add_column :users, :ext, :string, :limit => 5

    rename_column :users, :telephone, :phone
    change_column :users, :phone, :string, :limit => 10

    change_column :users, :fax, :string, :limit => 10
    change_column :users, :city, :string, :null => false, :limit => 45
    change_column :users, :state_cd, :string, :null => false, :limit => 2
    change_column :users, :zip, :string, :null => false, :limit => 5
  end

  def self.down
    remove_column :users, :ext
    rename_column :users, :phone, :telephone

    change_column :users, :fax, :string
    change_column :users, :city, :string
    change_column :users, :state_cd, :string
    change_column :users, :zip, :string
  end
end
