class DbCleanup < ActiveRecord::Migration
  def self.up
    remove_column :form_fields, :monitor_view_id
    remove_column :form_instances, :site_id
  end

  def self.down
    add_column :form_fields, :monitor_view_id, :integer
    add_column :form_instances, :site_id, :integer
  end
end
