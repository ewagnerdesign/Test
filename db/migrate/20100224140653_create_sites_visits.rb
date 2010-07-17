class CreateSitesVisits < ActiveRecord::Migration
  def self.up
    create_table :sites_visits do |t|
      t.integer  :site_id, :references => :sites, :null => false
      t.integer  :visit_id, :references => :visits, :null => false
      t.date     :start_date, :null => false
      t.date     :end_date, :null => false
      t.boolean  :active, :null => false
      t.integer  :date_constraint, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :sites_visits
  end
end
