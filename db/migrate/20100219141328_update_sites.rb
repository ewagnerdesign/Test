require "migration_helper"

class UpdateSites < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    remove_column :sites, :address
    remove_column :sites, :address_1
    remove_column :sites, :address_2
    remove_column :sites, :city
    remove_column :sites, :zip
    remove_column :sites, :time_zone
    remove_column :sites, :daylight_savings
    
    change_column :sites, :name, :string, :limit => 45, :null => false
    remove_column :sites, :agency_name

    rename_column :sites, :agency_number, :number
    change_column :sites, :number, :string, :limit => 45

    rename_column :sites, :provider_identifier, :identifier
    change_column :sites, :identifier, :string, :limit => 45

    add_column :sites, :address_id, :integer
    change_column :sites, :address_id, :integer, :null => false
    add_foreign_key :sites, :address_id, :addresses
    add_column :sites, :active, :boolean, :null => false, :default => true
  end

  def self.down
    add_column :sites, :daylight_savings, :boolean
    add_column :sites, :time_zone, :string
    add_column :sites, :zip, :string
    add_column :sites, :city, :string
    add_column :sites, :address_2, :string
    add_column :sites, :address_1, :string
    add_column :sites, :address, :string

    remove_column :sites, :active
    remove_foreign_key :sites, :address_id
    remove_column :sites, :address_id

    change_column :sites, :identifier, :string
    rename_column :sites, :identifier, :provider_identifier

    change_column :sites, :number, :string
    rename_column :sites, :number, :agency_number

    change_column :sites, :name, :string, :null => true
    add_column :sites, :agency_name, :string
  end
end
