class CreateFormVisits < ActiveRecord::Migration
  def self.up
    create_table :form_visits do |t|
      t.integer :form_id
      t.integer :visit_id
    end
  end

  def self.down
    drop_table :form_visits
  end
end
