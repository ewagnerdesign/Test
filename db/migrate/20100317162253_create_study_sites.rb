class CreateStudySites < ActiveRecord::Migration
  def self.up
    create_table :study_sites do |t|
      t.integer :study_id
      t.integer :site_id

      t.timestamps
    end
  end

  def self.down
    drop_table :study_sites
  end
end
