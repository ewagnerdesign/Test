require "migration_helper"

class UpdateCdashQuestions < ActiveRecord::Migration
  extend MigrationHelper

  def self.up
    rename_column :cdash_questions, :sdtm_id, :sdtm_category_id

    # remove duplicated columns: can be obtained by sdtm_category_id
    remove_column :cdash_questions, :sdtm_mapping
    remove_column :cdash_questions, :sdtm_term_code

    add_foreign_key :cdash_questions, :sdtm_category_id, :sdtm_categories
    add_foreign_key :cdash_questions, :domain_id, :domains
  end

  def self.down
    remove_foreign_key :cdash_questions, :domain_id
    remove_foreign_key :cdash_questions, :sdtm_category_id

    add_column :cdash_questions, :sdtm_term_code, :string
    add_column :cdash_questions, :sdtm_mapping, :string

    rename_column :cdash_questions, :sdtm_category_id, :sdtm_id
  end
end
