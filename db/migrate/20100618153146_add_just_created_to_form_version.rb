class AddJustCreatedToFormVersion < ActiveRecord::Migration
  def self.up
    add_column :form_versions, :just_created, :boolean, :null => false, :default => true
  end

  def self.down
    remove_column :form_versions, :just_created
  end
end
