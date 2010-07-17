class StudiesUpdate1 < ActiveRecord::Migration
  def self.up
    change_column :studies, :name, :string, :limit => 45, :null => false
    add_index :studies, :name, :unique => true
  end

  def self.down
    change_column :studies, :name, :string, :limit => 255, :null => false
    remove_index :studies, :name
  end
end
