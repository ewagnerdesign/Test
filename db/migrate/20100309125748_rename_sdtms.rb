require "migration_helper"

class RenameSdtms < ActiveRecord::Migration
  extend MigrationHelper 

  def self.up
    # sdtm_categories
    rename_table :cdashes, :sdtm_categories

    #PDF: code VARCHAR(45)
    #DB: code VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :code, :string, :null => false, :limit => 45

    #PDF: name VARCHAR(45)
    #DB: name VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :name, :string, :null => false, :limit => 255

    #PDF: cdisc_submission_value VARCHAR(45)
    #DB: submission_value VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :submission_value, :string, :null => false, :limit => 255

    #PDF: cdisc_synonym VARCHAR(45)
    #DB: synonyms VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :synonyms, :string, :null => false, :limit => 255

    #PDF: cdisc_definition VARCHAR(45)
    #DB: definition TEXT DEFAULT NULL,

    #PDF: cdisc_preferred_term VARCHAR(45)
    #DB: prefered_term VARCHAR(255) DEFAULT NULL,
    rename_column :sdtm_categories, :prefered_term, :cdisc_preferred_term
    change_column :sdtm_categories, :cdisc_preferred_term, :string, :null => false, :limit => 255

    #PDF: nci_preferred_term VARCHAR(45)
    #DB: prefered VARCHAR(255) DEFAULT NULL,
    rename_column :sdtm_categories, :prefered, :nci_preferred_term
    change_column :sdtm_categories, :nci_preferred_term, :string, :null => false, :limit => 255

    change_column :sdtm_categories, :extensible, :boolean, :null => false

    # ==========================================================================
    # sdtm_answers
    remove_foreign_key :sdtms, :cdash_id
    rename_table :sdtms, :sdtm_answers

    #PDF: code VARCHAR(45)
    #DB: code VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_answers, :code, :string, :null => false, :limit => 45

    #PDF: sdtm_category_id INT
    #DB: cdash_id INT(11) DEFAULT NULL,
    rename_column :sdtm_answers, :cdash_id, :sdtm_category_id
    change_column :sdtm_answers, :sdtm_category_id, :integer, :references => :cdashes, :null => false
    add_foreign_key :sdtm_answers, :sdtm_category_id, :sdtm_categories

    #PDF: cdisc_submission_value VARCHAR(45)
    #DB: submission_value VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_answers, :submission_value, :string, :null => false, :limit => 255

    #PDF: none
    #DB: synonyms VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_answers, :synonyms, :string, :null => false, :limit => 255

    #PDF: cdisc_definition VARCHAR(45)
    #DB: definition TEXT DEFAULT NULL,

    #PDF: cdisc_preferred_term VARCHAR(45)
    #DB: prefered_term VARCHAR(255) DEFAULT NULL,
    rename_column :sdtm_answers, :prefered_term, :cdisc_preferred_term
    change_column :sdtm_answers, :cdisc_preferred_term, :string, :null => false, :limit => 255

    #PDF: nci_preferred_term VARCHAR(45)
    #DB: prefered VARCHAR(255) DEFAULT NULL,
    rename_column :sdtm_answers, :prefered, :nci_preferred_term
    change_column :sdtm_answers, :nci_preferred_term, :string, :null => false, :limit => 255
  end

  def self.down
    # sdtm_answers
    
    #DB: prefered VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_answers, :nci_preferred_term, :string, :null => true, :limit => 255
    rename_column :sdtm_answers, :nci_preferred_term, :prefered

    #PDF: cdisc_preferred_term VARCHAR(45)
    #DB: prefered_term VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_answers, :cdisc_preferred_term, :string, :null => true, :limit => 255
    rename_column :sdtm_answers, :cdisc_preferred_term, :prefered_term
    
    #PDF: none
    #DB: synonyms VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_answers, :synonyms, :string, :null => true, :limit => 255
    
    #PDF: cdisc_submission_value VARCHAR(45)
    #DB: submission_value VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_answers, :submission_value, :string, :null => true, :limit => 255
    
    #PDF: sdtm_category_id INT
    #DB: cdash_id INT(11) DEFAULT NULL,
    remove_foreign_key :sdtm_answers, :sdtm_category_id
    rename_column :sdtm_answers, :sdtm_category_id, :cdash_id

    #PDF: code VARCHAR(45)
    #DB: code VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_answers, :code, :string, :null => true, :limit => 45
    
    rename_table :sdtm_answers, :sdtms

    # ==========================================================================
    change_column :sdtm_categories, :extensible, :boolean, :null => true

    #PDF: nci_preferred_term VARCHAR(45)
    #DB: prefered VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :nci_preferred_term, :string, :null => true, :limit => 255
    rename_column :sdtm_categories, :nci_preferred_term, :prefered

    #PDF: cdisc_preferred_term VARCHAR(45)
    #DB: prefered_term VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :cdisc_preferred_term, :string, :null => true, :limit => 255
    rename_column :sdtm_categories, :cdisc_preferred_term, :prefered_term

    #PDF: cdisc_synonym VARCHAR(45)
    #DB: synonyms VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :synonyms, :string, :null => true, :limit => 255

    #PDF: cdisc_synonym VARCHAR(45)
    #DB: synonyms VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :synonyms, :string, :null => true, :limit => 255

    #PDF: cdisc_submission_value VARCHAR(45)
    #DB: submission_value VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :submission_value, :string, :null => true, :limit => 255

    #PDF: name VARCHAR(45)
    #DB: name VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :name, :string, :null => true, :limit => 45

    #PDF: code VARCHAR(45)
    #DB: code VARCHAR(255) DEFAULT NULL,
    change_column :sdtm_categories, :code, :string, :null => true, :limit => 45

    rename_table :sdtm_categories, :cdashes
    add_foreign_key :sdtms, :cdash_id, :cdashes
  end
end
