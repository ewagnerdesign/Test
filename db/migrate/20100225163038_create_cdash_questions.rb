class CreateCdashQuestions < ActiveRecord::Migration
  def self.up
    create_table :cdash_questions do |t|
      t.string :data_collection_field
      t.references :domain
      t.integer :number
      t.string :variable_name
      t.text :definition
      t.text :completion_instructions
      t.text :sponsor_info
      t.string :core
      t.string :sdtm_mapping
      t.string :sdtm_term_code
      t.integer :sdtm_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cdash_questions
  end
end
