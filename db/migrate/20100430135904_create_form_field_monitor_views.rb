class CreateFormFieldMonitorViews < ActiveRecord::Migration
  def self.up
    create_table :form_field_monitor_views do |t|
      t.integer :form_field_id, :null => false
      t.integer :monitor_view_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :form_field_monitor_views
  end
end