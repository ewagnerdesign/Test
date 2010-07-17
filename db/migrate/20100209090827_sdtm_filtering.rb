class SdtmFiltering < ActiveRecord::Migration
  def self.up
    add_column :sdtms, :cdash_id, :integer, :references => :cdashes 

    remove_column :sdtms, :extensible # delete "Codelist Extensible" column
    remove_column :sdtms, :name # delete "Codelist Name" column
    remove_column :sdtms, :codelist # delete "Codelist Code" column
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't recover the deleted data"
  end
end
