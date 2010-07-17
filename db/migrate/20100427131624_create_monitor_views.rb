class CreateMonitorViews < ActiveRecord::Migration
  def self.up
    create_table :monitor_views do |t|
      t.string :name, :limit => 45
      t.belongs_to :study, :null => false
      t.belongs_to :form, :null => false

      t.timestamps
    end

    add_column :form_field_values, :monitor_view_id, :integer
  end

  def self.down
    drop_table :monitor_views
    remove_column :form_field_values, :monitor_view_id
  end
end
