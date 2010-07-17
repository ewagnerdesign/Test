class AddFieldsToVisit < ActiveRecord::Migration
  def self.up
    change_table :visits do |t|
      t.date :start_date
      t.date :end_date
      t.boolean :active
      t.text :notes
      t.references :study
      t.integer :prev_visit_start_offset_day
      t.integer :prev_visit_end_offset_day
      t.integer :prev_visit_id, :references => :visits
    end
  end

  def self.down
    change_table :visits do |t|
      t.remove :start_date
      t.remove :end_date
      t.remove :active
      t.remove :notes
      t.remove :study_id
      t.remove :prev_visit_start_offset_day
      t.remove :prev_visit_end_offset_day
      t.remove :prev_visit_id
    end
  end
end
