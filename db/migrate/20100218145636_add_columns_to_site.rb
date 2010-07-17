class AddColumnsToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :agency_name, :string
    add_column :sites, :agency_number, :string
    add_column :sites, :provider_identifier, :string
    add_column :sites, :address_1, :string
    add_column :sites, :address_2, :string
    add_column :sites, :city, :string
    # add_column :sites, :state, :string
    add_column :sites, :zip, :string
    add_column :sites, :time_zone, :string
    add_column :sites, :daylight_savings, :boolean
  end

  def self.down
    remove_column :sites, :agency_name
    remove_column :sites, :agency_number
    remove_column :sites, :provider_identifier
    remove_column :sites, :address_1
    remove_column :sites, :address_2
    remove_column :sites, :city
    # remove_column :sites, :state
    remove_column :sites, :zip
    remove_column :sites, :time_zone
    remove_column :sites, :daylight_savings
  end
end
