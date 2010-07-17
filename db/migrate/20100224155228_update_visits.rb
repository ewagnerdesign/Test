require "migration_helper"
class UpdateVisits < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    remove_column :visits, :visit
    remove_column :visits, :status
    remove_column :visits, :submited_at
    remove_column :visits, :visited_at
    remove_foreign_key :visits, :subject_id
    remove_column :visits, :subject_id
    remove_column :visits, :site_id

    add_column :visits, :number, :string, :null => false, :limit => 45
    add_column :visits, :name, :string, :null => false, :limit => 255
  end

  def self.down
    remove_column :visits, :name
    remove_column :visits, :number

    add_column :visits, :visit, :string
    add_column :visits, :status, :string
    add_column :visits, :submited_at, :datetime
    add_column :visits, :visited_at, :datetime
    add_column :visits, :subject_id, :integer, :references => :subjects
    add_foreign_key :visits, :subject_id, :subjects
    add_column :visits, :site_id, :integer, :references => :sites
  end
end