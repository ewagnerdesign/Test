require "migration_helper"

class SdtmAnswersUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    add_index :sdtm_answers, [:sdtm_category_id, :code], :unique => true
  end

  def self.down
    #NOTE. Do not remove, please, that stupid remove/create foreign key
    #wrapping around remove composed index. It's appeared that MySQL
    #do not allow removing of the composed indexes with foreign key columns 
    #inside
    remove_foreign_key :sdtm_answers, :sdtm_category_id
    remove_index :sdtm_answers, [:sdtm_category_id, :code]
    add_foreign_key :sdtm_answers, :sdtm_category_id, :sdtm_categories
  end
end
