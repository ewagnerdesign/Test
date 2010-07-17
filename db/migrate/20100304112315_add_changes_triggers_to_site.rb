class AddChangesTriggersToSite < ActiveRecord::Migration
  def self.up
    Rake::Task["changes_monitor:add"].invoke(Site)
  end

  def self.down
    Rake::Task["changes_monitor:remove"].invoke(Site)
  end
end
