class CreateFormFields < ActiveRecord::Migration
  def self.up
    create_table :form_fields do |t|
      t.integer :form_id
      t.text :validators
      t.text :field_type
      t.text :options
      t.integer :sdtm_category_id
      t.integer :cdash_question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :form_fields
  end
end
