require "migration_helper"

class FormInstanceUpdate < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    add_foreign_key :form_instances, :form_id, :forms
  end

  def self.down
    remove_foreign_key :form_instances, :form_id
  end
end
