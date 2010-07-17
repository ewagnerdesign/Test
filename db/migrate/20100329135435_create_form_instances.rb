class CreateFormInstances < ActiveRecord::Migration
  def self.up
    create_table :form_instances do |t|
      t.integer :form_id
      t.integer :visit_instance_id

      t.timestamps
    end
  end

  def self.down
    drop_table :form_instances
  end
end
