class AddClosedByToQuery < ActiveRecord::Migration
  def self.up
    add_column :queries, :closed_by_id, :integer
  end

  def self.down
    remove_column :queries, :closed_by_id
  end
end
