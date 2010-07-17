class RemoveEcrfs < ActiveRecord::Migration
  def self.up
    drop_table :ecrfs
  end

  def self.down
    # obsolete variant, just for rollback
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
end
