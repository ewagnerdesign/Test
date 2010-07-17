class EventActualDateTimeToDatetime < ActiveRecord::Migration
  def self.up
    change_column :events, :actual_date_time, :datetime
  end

  def self.down
    change_column :events, :actual_date_time, :date
  end
end
