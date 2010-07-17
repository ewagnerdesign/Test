class RemoveEmployee < ActiveRecord::Migration
  def self.up
    drop_table :employees
  end

  def self.down
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :site_id, :references => :sites
      t.timestamps
    end
  end

end
