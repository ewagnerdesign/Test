class CreateStudyArmVisits < ActiveRecord::Migration
  def self.up
    create_table :study_arm_visits do |t|
      t.integer :study_arm_id, :null => false
      t.integer :visit_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :study_arm_visits
  end
end
