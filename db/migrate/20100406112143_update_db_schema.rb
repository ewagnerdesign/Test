class UpdateDbSchema < ActiveRecord::Migration
  def self.up
    drop_table :addresses
    drop_table :vital_signs
  end

  def self.down
    create_table :addresses do |t|
      t.string    :line1,               :null => false
      t.string    :line2,               :null => true
      t.string    :city,                :null => false
      t.string    :state_cd,            :null => false, :limit => 2
      t.string    :zip,                 :null => false, :limit => 5
    end

    # obsolete variant, just for rollback
    create_table :vital_signs do |t|
      t.date :date_of_measurment
      t.integer :not_done_id, :references => :sdtms
      t.float :height
      t.integer :height_unit, :references => :sdtms
      t.float :weight
      t.integer :weight_unit, :references => :sdtms
      t.integer :diastolic
      t.integer :sistolic
      t.integer :bp_location_id, :references => :sdtms
      t.integer :bp_position_id, :references => :sdtms
      t.integer :pulse
      t.integer :pulse_location_id, :references => :sdtms
      t.integer :pulse_position_id, :references => :sdtms
      t.float :temperature
      t.integer :temperature_unit, :references => :sdtms
      t.integer :temperature_location_id, :references => :sdtms
      t.integer :frame_size, :references => :sdtms

      t.timestamps
    end
  end
end
