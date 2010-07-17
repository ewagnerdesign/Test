class CreateEcrves < ActiveRecord::Migration
  def self.up
    create_table :ecrfs do |t|
      t.string :name
      t.string :descrip
      t.text :notes
      t.text :html
      t.text :json
      t.integer :study_id, :references => :studies
      t.timestamps
    end
  end

  def self.down
    drop_table :ecrfs
  end
end
