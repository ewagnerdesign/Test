class AddColumnsToStudy < ActiveRecord::Migration
  def self.up
    add_column :studies, :title, :string
    add_column :studies, :protocol_no, :string
    add_column :studies, :CRO, :string
    add_column :studies, :phase, :string
    add_column :studies, :length, :integer
    
  end

  def self.down
    remove_column :studies, :title
    remove_column :studies, :protocol_no
    remove_column :studies, :CRO
    remove_column :studies, :phase
    remove_column :studies, :length
  end
end
