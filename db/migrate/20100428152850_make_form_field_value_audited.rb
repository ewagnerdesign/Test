class MakeFormFieldValueAudited < ActiveRecord::Migration
  def self.up
    add_column :form_field_values, :lock_version, :integer
    Rake::Task["changes_monitor:add"].invoke(FormFieldValue)
  end

  def self.down
    remove_column :form_field_values, :lock_version
    Rake::Task["changes_monitor:remove"].invoke(FormFieldValue)
  end
end
