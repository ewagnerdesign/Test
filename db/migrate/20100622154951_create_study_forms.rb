class CreateStudyForms < ActiveRecord::Migration
  def self.up
    create_table :study_forms do |t|
      t.belongs_to :study
      t.belongs_to :form

      t.timestamps
    end
  end

  def self.down
    drop_table :study_forms
  end
end
