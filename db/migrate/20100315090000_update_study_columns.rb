class UpdateStudyColumns < ActiveRecord::Migration
  def self.up
    change_table :studies do |t|
      #remove old fields not needed in the current schema
      t.remove   :notes
      t.remove   :CRO
      t.remove   :phase
      t.remove   :length
      #rename
      t.rename   :protocol_no, :protocol_number
      #add new fields
      t.string   :name
      t.string   :drug_name
      t.date     :fpfv
      t.date     :lplv
      t.date     :expected_db_lock 
      t.integer  :expected_sites_number
      t.integer  :sponsor_id
      t.boolean  :active
    end

#    t.string   "title"
#    t.string   "protocol_no"

  end

  def self.down
    change_table :studies do |t|
      t.text     :notes
      t.string   :CRO
      t.string   :phase
      t.integer  :length
      t.rename   :protocol_number, :protocol_no
      t.remove   :name
      t.remove   :drug_name
      t.remove   :fpfv
      t.remove   :lplv
      t.remove   :expected_db_lock 
      t.remove  :expected_sites_number
      t.remove  :sponsor_id
      t.remove  :active
    end
  end
end
