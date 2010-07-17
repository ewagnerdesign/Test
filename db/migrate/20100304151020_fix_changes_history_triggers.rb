class FixChangesHistoryTriggers < ActiveRecord::Migration
  def self.up
    Rake::Task["changes_monitor:remove"].invoke(Site)
    Rake::Task["changes_monitor:add"].invoke(Site)
  end

  def self.down
  end
end

