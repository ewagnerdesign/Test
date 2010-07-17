class CreateQueryComments < ActiveRecord::Migration
  def self.up
    create_table :query_comments do |t|
      t.references :user
      t.references :query
      t.references :query_type
      t.references :query_action
      t.string :comment
    end
    
    remove_column :queries, :parent_query_id
    remove_column :queries, :query_action_id
    remove_column :queries, :query_type_id
  end

  def self.down
    drop_table :query_comments
    
    add_column :queries, :parent_query_id, :integer, :null => true
    add_column :queries, :query_action_id, :integer, :null => false
    add_column :queries, :query_type_id, :integerp, :null => false
  end
end
