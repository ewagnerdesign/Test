class AddPositionToQueryForTree < ActiveRecord::Migration
  def self.up
    change_column :queries, :parent_query_id, :integer, :null => false , :default => 0
    add_column :queries, :position, :integer
    add_index :queries, :parent_query_id
  end

  def self.down
    change_column :queries, :parent_query_id, :integer, :null => true
    remove_column :queries, :position
    remove_index :queries, :parent_query_id
  end
end
