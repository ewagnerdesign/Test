class CreateFormFieldValues < ActiveRecord::Migration
  def self.up
    create_table :form_field_values do |t|
      t.integer :form_instance_id
      t.integer :form_field_id
      t.text :value
      t.string :override_reason

      t.timestamps
    end
  end

  def self.down
    drop_table :form_field_values
  end
end
