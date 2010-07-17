class CreateDomains < ActiveRecord::Migration
  def self.up
    create_table :domains do |t|
      t.string :code
      t.string :name
      t.string :domain_class
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :domains
  end
end
