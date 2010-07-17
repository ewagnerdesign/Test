class AddPhonesToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :phone, :string, :limit => 10
    add_column :sites, :ext, :string, :limit => 5
    add_column :sites, :fax, :string, :limit => 10
  end

  def self.down
    remove_column :sites, :phone
    remove_column :sites, :ext
    remove_column :sites, :fax
  end
end
