class AddSubmissionFieldsToFormInstance < ActiveRecord::Migration
  def self.up
    change_table :form_instances do |t|
      t.boolean    :submitted
      t.references :submitted_by
      t.datetime   :submitted_at
    end
  end

  def self.down
    change_table :form_instances do |t|
      t.remove           :submitted
      t.remove_reference :submitted_by
      t.remove           :submitted_at
    end
  end
end
