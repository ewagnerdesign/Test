class AddOverridesToVitalSign < ActiveRecord::Migration
  def self.up
    add_column :vital_signs, :date_of_measurment_override, :string
    add_column :vital_signs, :height_override, :string
    add_column :vital_signs, :weight_override, :string
    add_column :vital_signs, :diastolic_override, :string
    add_column :vital_signs, :systolic_override, :string
    add_column :vital_signs, :pulse_override, :string
  end

  def self.down
    remove_column :vital_signs, :date_of_measurment_override
    remove_column :vital_signs, :height_override
    remove_column :vital_signs, :weight_override
    remove_column :vital_signs, :diastolic_override
    remove_column :vital_signs, :systolic_override
    remove_column :vital_signs, :pulse_override
  end
end
