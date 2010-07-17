class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.string :visit
      t.string :status
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :submited_at
      t.datetime :visited_at
      t.integer  :subject_id, :references => :subjects
      t.integer  :site_id, :references => :sites

      t.timestamps
    end
  end

  def self.down
    drop_table :visits
  end
end
