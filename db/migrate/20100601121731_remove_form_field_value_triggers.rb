class RemoveFormFieldValueTriggers < ActiveRecord::Migration
  def self.up
    Rake::Task["changes_monitor:remove"].invoke(FormFieldValue)
  end

  def self.down
    Rake::Task["changes_monitor:add"].invoke(FormFieldValue)
  end
end
