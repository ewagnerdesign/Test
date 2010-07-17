require "migration_helper"
class AddForeignKeys < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    add_foreign_key(:sdtms, :cdash_id, :cdashes)

    add_foreign_key(:employees, :site_id, :sites)
    add_foreign_key(:subjects, :site_id, :sites)

    add_foreign_key(:ecrfs, :study_id, :studies)
    add_foreign_key(:sites, :study_id, :studies)
    
    add_foreign_key(:visits, :subject_id, :subjects)

    add_foreign_key(:vital_signs, :not_done_id, :sdtms)
    add_foreign_key(:vital_signs, :height_unit_id, :sdtms)
    add_foreign_key(:vital_signs, :weight_unit_id, :sdtms)
    add_foreign_key(:vital_signs, :bp_location_id, :sdtms)
    add_foreign_key(:vital_signs, :pulse_location_id, :sdtms)
    add_foreign_key(:vital_signs, :pulse_position_id, :sdtms)
    add_foreign_key(:vital_signs, :temperature_unit_id, :sdtms)
    add_foreign_key(:vital_signs, :temperature_location_id, :sdtms)
  end

  def self.down
    remove_foreign_key(:sdtms, :cdash_id)

    remove_foreign_key(:employees, :site_id)
    remove_foreign_key(:subjects, :site_id)

    remove_foreign_key(:ecrfs, :study_id)
    remove_foreign_key(:sites, :study_id)

    remove_foreign_key(:visits, :subject_id)

    remove_foreign_key(:vital_signs, :not_done_id)
    remove_foreign_key(:vital_signs, :height_unit_id)
    remove_foreign_key(:vital_signs, :weight_unit_id)
    remove_foreign_key(:vital_signs, :bp_location_id)
    remove_foreign_key(:vital_signs, :pulse_location_id)
    remove_foreign_key(:vital_signs, :pulse_position_id)
    remove_foreign_key(:vital_signs, :temperature_unit_id)
    remove_foreign_key(:vital_signs, :temperature_location_id)
  end
end
