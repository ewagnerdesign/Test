class CreateCdashes < ActiveRecord::Migration
  def self.up
    create_table :cdashes do |t|
      t.string :code
      t.boolean :extensible
      t.string :name
      t.string :submission_value
      t.string :prefered_term
      t.string :synonyms
      t.text :definition
      t.string :prefered

      t.timestamps
    end
  end

  def self.down
    drop_table :cdashes
  end
end
