class CreateQueryTypes < ActiveRecord::Migration
  def self.up
    create_table :query_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :query_types
  end
end
