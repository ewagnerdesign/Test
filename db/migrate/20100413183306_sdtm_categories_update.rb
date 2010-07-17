class SdtmCategoriesUpdate < ActiveRecord::Migration
  def self.up
    add_index :sdtm_categories, :code, :unique => true
  end

  def self.down
    remove_index :sdtm_categories, :code
  end
end
