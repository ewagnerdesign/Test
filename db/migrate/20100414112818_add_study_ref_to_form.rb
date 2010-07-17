class AddStudyRefToForm < ActiveRecord::Migration
  def self.up
    add_column :forms, :study_id, :integer
    add_column :forms, :cumulative, :boolean, :null => false, :default => 0
  end

  def self.down
    remove_column :forms, :study_id
    remove_column :forms, :cumulative
  end
end
