class AddFieldIdToFormField < ActiveRecord::Migration
  def self.up
    add_column :form_fields, :field_id, :integer, :null => false
    FormField.all.each { |f| f.update_attribute(:field_id, f.id)}
    add_index :form_fields, :field_id, :unique => true
  end

  def self.down
    remove_index :form_fields, :field_id
    remove_column :form_fields, :field_id
  end
end
