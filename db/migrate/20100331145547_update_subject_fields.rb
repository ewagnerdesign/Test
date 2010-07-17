class UpdateSubjectFields < ActiveRecord::Migration
  extend MigrationHelper
  
  def self.up
    remove_foreign_key(:subjects, :site_id)
    
    change_table :subjects do |t|
      #remove old columns
      t.remove   :site_id
      t.remove   :name
      t.remove   :randomization_number
      t.remove   :screen_number
      t.remove   :status
      t.remove   :status_date

      #add new columns
      t.string      :code
      t.references  :study
      t.references  :study_arm
    end
  end

  def self.down
    add_foreign_key(:subjects, :site_id)
 
    change_table :subjects do |t|
      #add old columns
      t.integer  :site_id
      t.string   :name
      t.integer  :randomization_number
      t.integer  :screen_number
      t.string   :status
      t.date     :status_date

      #remove new columns
      t.remove   :code
      t.remove   :study
      t.remove   :study_arm
    end
  end
end


