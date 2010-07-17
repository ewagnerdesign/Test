class AddStudyRefToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :study_id, :integer
  end

  def self.down
    remove_column :events, :study_id
  end
end
