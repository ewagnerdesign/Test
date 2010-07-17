class AddStatusToVitalSign < ActiveRecord::Migration
  def self.up
    add_column :vital_signs, :form_status, :string
  end

  def self.down
    remove_column :vital_signs, :form_status
  end
end
