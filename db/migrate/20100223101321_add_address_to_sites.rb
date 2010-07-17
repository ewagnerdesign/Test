require "migration_helper"

class AddAddressToSites < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    add_column :sites, :address_1, :string, :null => true
    add_column :sites, :address_2, :string, :null => true
    add_column :sites, :city, :string, :null => true
    add_column :sites, :state_cd, :string, :null => true
    add_column :sites, :zip, :string, :null => true

    remove_foreign_key :sites, :address_id
    remove_column :sites, :address_id
    
    change_column :sites, :address_1, :string, :null => false
    change_column :sites, :city, :string, :null => false, :limit => 45
    change_column :sites, :state_cd, :string, :null => false, :limit => 2
    change_column :sites, :zip, :string, :null => false, :limit => 5
  end

  def self.down
    add_column :sites, :address_id, :integer
    add_foreign_key :sites, :address_id, :addresses

    remove_column :sites, :address_1
    remove_column :sites, :address_2
    remove_column :sites, :city
    remove_column :sites, :state_cd
    remove_column :sites, :zip

  end
end
