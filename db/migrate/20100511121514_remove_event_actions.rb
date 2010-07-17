class RemoveEventActions < ActiveRecord::Migration
  def self.up
    remove_column :form_instances, :event_id
    drop_table :events    
  end

  def self.down
    create_table "events", :force => true do |t|
      t.integer  "visit_id"
      t.integer  "site_id"    , :null => false
      t.integer  "subject_id" , :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "actual_date_time"
    end
    
    add_column :form_instances, :event_id, :integer
  end
end
