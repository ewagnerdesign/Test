class CreateStudySiteUsers < ActiveRecord::Migration
  def self.up
    create_table :study_site_users do |t|
      t.references :study
      t.references :site_user

      t.timestamps
    end
  end

  def self.down
    drop_table :study_site_users
  end
end
