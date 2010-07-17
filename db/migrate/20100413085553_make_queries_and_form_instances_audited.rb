class MakeQueriesAndFormInstancesAudited < ActiveRecord::Migration
  def self.up
    add_column :queries, :lock_version, :integer
    add_column :form_instances, :lock_version, :integer

    Rake::Task["changes_monitor:add"].invoke(Query)
    Rake::Task["changes_monitor:add"].invoke(FormInstance)
  end

  def self.down
    remove_column :queries, :lock_version
    remove_column :form_instances, :lock_version

    Rake::Task["changes_monitor:remove"].invoke(Query)
    Rake::Task["changes_monitor:remove"].invoke(FormInstance)
  end
end
