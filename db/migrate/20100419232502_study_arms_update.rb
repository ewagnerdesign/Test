require "migration_helper"

class StudyArmsUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    add_index :study_arms, [:study_id, :code], :unique => true
  end

  def self.down
    #NOTE. Do not remove, please, that stupid remove/create foreign key
    #wrapping around remove composed index. It's appeared that MySQL
    #do not allow removing of the composed indexes with foreign key columns 
    #inside
    remove_foreign_key :study_arms, :study_id
    remove_index :study_arms, [:study_id, :code]
    add_foreign_key :study_arms, :study_id, :studies
  end
end
