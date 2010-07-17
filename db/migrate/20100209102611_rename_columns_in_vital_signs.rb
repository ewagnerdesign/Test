class RenameColumnsInVitalSigns < ActiveRecord::Migration
  def self.up
    rename_column :vital_signs, :temperature_unit, :temperature_unit_id
    rename_column :vital_signs, :sistolic, :systolic
    rename_column :vital_signs, :height_unit, :height_unit_id
    rename_column :vital_signs, :weight_unit, :weight_unit_id
    rename_column :vital_signs, :frame_size, :frame_size_id
  end

  def self.down
    rename_column :vital_signs, :temperature_unit_id, :temperature_unit
    rename_column :vital_signs, :systolic, :sistolic
    rename_column :vital_signs, :height_unit_id, :height_unit
    rename_column :vital_signs, :weight_unit_id, :weight_unit
    rename_column :vital_signs, :frame_size_id, :frame_size
  end
end
