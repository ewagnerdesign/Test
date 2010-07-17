class RemoveCodeFromSubjects < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    remove_foreign_key :subjects, :study_id
    remove_index :subjects, [:study_id, :code]
    remove_column :subjects, :code
    add_index :subjects, [:study_id, :number], :unique => true
  end

  def self.down
    remove_index :subjects, [:study_id, :number]
    add_column :subjects, :code, :string
    add_index :subjects, [:study_id, :code], :unique => true
    add_foreign_key :subjects, :study_id, :studies
  end
end
