class AddFieldsToQuery < ActiveRecord::Migration
  def self.up
    change_table :queries do |t|
      t.string :comment, :null => false
      t.references :user, :null => false
      t.references :form_field_value, :null => false
      t.references :query_type, :null => false
      t.integer :parent_query_id, :references => :queries, :null => true
    end
  end

  def self.down
    change_table :queries do |t|
      t.remove :comment
      t.remove :user_id
      t.remove :form_field_value_id
      t.remove :query_type_id
      t.remove :parent_query_id
    end

  end
end
