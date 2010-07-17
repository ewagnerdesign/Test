class CreateFormVersions < ActiveRecord::Migration
  def self.up
    create_table :form_versions do |t|
      t.belongs_to :form
      t.text :metadata, :null => false
      t.text :html
      t.string :name, :limit => 45, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :form_versions
  end
end
