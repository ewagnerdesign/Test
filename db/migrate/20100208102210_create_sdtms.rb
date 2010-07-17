class CreateSdtms < ActiveRecord::Migration
  def self.up
    create_table :sdtms do |t|
      t.string :code
      t.string :codelist
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
    drop_table :sdtms
  end
end
