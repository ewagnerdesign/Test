class UpdateFormsAndEvents < ActiveRecord::Migration
  def self.up
    remove_column :forms, :study_id
    remove_column :events, :study_id
  end

  def self.down
    add_column :events, :study_id, :integer
    add_column :forms, :study_id, :integer
  end
end
