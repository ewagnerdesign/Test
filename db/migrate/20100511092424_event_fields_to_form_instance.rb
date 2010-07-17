class EventFieldsToFormInstance < ActiveRecord::Migration
  def self.up
    change_table :form_instances do |t|
      t.references :visit
      t.references :site
      t.datetime   :actual_date_time
    end
  end

  def self.down
    change_table :form_instances do |t|
      t.remove :visit
      t.remove :site
      t.remove :actual_date_time
    end
  end
end
