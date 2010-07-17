class UpdateTriggersQuerySiteFormInstance < ActiveRecord::Migration
  def self.up
    Rake::Task["changes_monitor:add"].invoke(Query)
    Rake::Task["changes_monitor:add"].invoke(FormInstance)
    Rake::Task["changes_monitor:add"].invoke(Site)
  end

  def self.down
  end
end
