class AddFieldsToSubject < ActiveRecord::Migration
  def self.up
    change_table :subjects do |t|
      t.integer  :number, :null => false
      t.integer  :randomization_number
      t.string   :gender, :null => false, :limit => 1
      t.date     :dob, :null => false
      t.datetime :consent_datetime, :null => false
      t.boolean  :inactive, :null => false
    end
  end

  def self.down
    change_table :subjects do |t|
      t.remove  :number
      t.remove  :randomization_number
      t.remove  :gender
      t.remove  :dob
      t.remove  :consent_datetime
      t.remove  :inactive
    end
  end
end
