class FormFieldFieldIdNull < ActiveRecord::Migration
  def self.up
    change_column :form_fields, :field_id, :integer, :null => true
  end

  def self.down
    change_column :form_fields, :field_id, :integer, :null => false
  end
end
