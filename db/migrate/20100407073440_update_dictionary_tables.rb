class UpdateDictionaryTables < ActiveRecord::Migration
  def self.up
    change_column :cdash_questions, :domain_id, :int, :null => false, :references => :domains
    change_column :cdash_questions, :number, :int, :null => false
    change_column :cdash_questions, :variable_name, :string, :limit => 255 , :null => false
    change_column :cdash_questions, :definition, :text, :null => false
    change_column :cdash_questions, :sponsor_info, :text, :null => true
    change_column :cdash_questions, :core, :string, :limit => 255 , :null => false

    change_column :therapeutic_areas, :name, :string, :limit => 255 , :null => false

    change_column :domains, :code, :string, :limit => 255 , :null => false
    change_column :domains, :name, :string, :limit => 255 , :null => false
    change_column :domains, :domain_class, :string, :limit => 255 , :null => false
  end

  def self.down
    change_column :cdash_questions, :domain_id, :int, :null => true, :references => :domains
    change_column :cdash_questions, :number, :int, :null => true
    change_column :cdash_questions, :variable_name, :string, :limit => 255 , :null => true
    change_column :cdash_questions, :definition, :text, :null => true
    change_column :cdash_questions, :sponsor_info, :text, :null => true
    change_column :cdash_questions, :core, :string, :limit => 255 , :null => true

    change_column :therapeutic_areas, :name, :string, :limit => 255 , :null => true

    change_column :domains, :code, :string, :limit => 255 , :null => true
    change_column :domains, :name, :string, :limit => 255 , :null => true
    change_column :domains, :domain_class, :string, :limit => 255 , :null => true
  end
end
