class VitalSignAddTemperatureOverride < ActiveRecord::Migration
  def self.up
    add_column :vital_signs, :temperature_override, :string
  end

  def self.down
    remove_column :vital_signs, :temperature_override
  end
end
