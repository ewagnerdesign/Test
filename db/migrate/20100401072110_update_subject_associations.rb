class UpdateSubjectAssociations < ActiveRecord::Migration
  def self.up
    add_column :form_instances, :subject_id, :integer
  end

  def self.down
    remove_column :form_instances, :subject_id
  end
end
