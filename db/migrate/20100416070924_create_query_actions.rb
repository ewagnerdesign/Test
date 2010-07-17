class CreateQueryActions < ActiveRecord::Migration
  def self.up
    create_table :query_actions do |t|
      t.string :name, :null => false
      t.timestamps
    end

    add_column :queries, :closed, :boolean, :null => false, :default => 0
    add_column :queries, :query_action_id, :integer
  end

  def self.down
    drop_table :query_actions

    remove_columns :queries, :closed, :query_action_id
  end
end
