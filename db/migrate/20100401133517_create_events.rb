class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.date :visit_date
      t.references :visit
      t.references :site
      t.references :subject

      t.timestamps
    end

    rename_column :form_instances, :visit_instance_id, :event_id
  end

  def self.down
    drop_table :events
    rename_column :form_instances, :event_id, :visit_instance_id
  end
end
