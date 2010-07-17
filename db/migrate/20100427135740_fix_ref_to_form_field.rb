class FixRefToFormField < ActiveRecord::Migration
  def self.up
    remove_column :form_field_values, :monitor_view_id
    add_column :form_fields, :monitor_view_id, :integer
  end

  def self.down
    add_column :form_field_values, :monitor_view_id, :integer
    remove_column :form_fields, :monitor_view_id
  end
end

