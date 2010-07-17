class AddTimestampsToQueryComment < ActiveRecord::Migration
  def self.up
    change_table :query_comments do |t|
      t.timestamps
    end
  end

  def self.down
    remove_column :query_comments, :created_at
    remove_column :query_comments, :updated_at
  end
end
