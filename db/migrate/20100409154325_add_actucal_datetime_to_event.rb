class AddActucalDatetimeToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :actual_date_time, :date
  end

  def self.down
    remove_column :events, :actual_date_time
  end
end
