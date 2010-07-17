class CreateStudyUsers < ActiveRecord::Migration
  def self.up
    create_table :study_users do |t|
      t.references :study
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :study_users
  end
end
