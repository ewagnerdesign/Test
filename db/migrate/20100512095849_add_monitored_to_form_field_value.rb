class AddMonitoredToFormFieldValue < ActiveRecord::Migration
  def self.up
    add_column :form_field_values, :monitored, :boolean, :null => false
  end

  def self.down
    remove_column :form_field_values, :monitored
  end
end
