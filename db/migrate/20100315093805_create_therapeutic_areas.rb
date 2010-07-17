class CreateTherapeuticAreas < ActiveRecord::Migration
  def self.up
    create_table :therapeutic_areas do |t|
      t.string :name
      t.timestamps
    end

    add_column :studies, :therapeutic_area_id, :integer
  end

  def self.down
    drop_table :therapeutic_areas
    remove_column :studies, :therapeutic_area_id
  end
end

