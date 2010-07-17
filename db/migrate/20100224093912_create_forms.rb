class CreateForms < ActiveRecord::Migration
  def self.up
    create_table :forms do |t|
      t.string :name
      t.text :metadata
      t.text :html
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :forms
  end
end
