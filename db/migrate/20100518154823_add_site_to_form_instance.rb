class AddSiteToFormInstance < ActiveRecord::Migration
  def self.up
    add_column :subjects, :site_id, :integer, :null => false
  end

  def self.down
    remove_column :subjects, :site_id
  end
end
