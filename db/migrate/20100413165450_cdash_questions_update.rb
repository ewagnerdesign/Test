class CdashQuestionsUpdate < ActiveRecord::Migration
  def self.up
    change_column :cdash_questions, :data_collection_field, :string, :limit => 255, :null => false
    add_index :cdash_questions, :variable_name, :unique => true
  end

  def self.down
    change_column :cdash_questions, :data_collection_field, :string, :limit => 255, :null => true
    remove_index :cdash_questions, :variable_name
  end
end
