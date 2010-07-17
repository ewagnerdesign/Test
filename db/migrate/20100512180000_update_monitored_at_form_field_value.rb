class UpdateMonitoredAtFormFieldValue < ActiveRecord::Migration
  def self.up
    change_column :form_field_values, :monitored, :boolean, :null => false, :default => false
  end

  def self.down
  end
end
