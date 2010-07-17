class RemoveUniqFromFieldFieldId < ActiveRecord::Migration
  def self.up
    remove_index :form_fields, :field_id
    add_index :form_fields, :field_id
  end

  def self.down
  end
end
