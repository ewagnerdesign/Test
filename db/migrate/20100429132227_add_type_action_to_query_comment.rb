class AddTypeActionToQueryComment < ActiveRecord::Migration
  def self.up
    remove_column :query_comments, :query_action_id
    remove_column :query_comments, :query_type_id

    add_column :query_comments, :query_type, :string, :null => false
    add_column :query_comments, :query_action, :string

    drop_table :query_types
    drop_table :query_actions
  end

  def self.down
    create_table "query_actions" do |t|
      t.string   "name",       :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "query_types" do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "key",        :null => false
    end

    remove_column :query_comments, :query_type
    remove_column :query_comments, :query_action

    add_column :query_comments, :query_action_id, :integer
    add_column :query_comments, :query_type_id, :null => false
  end
end
