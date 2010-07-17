class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string    :line1,               :null => false
      t.string    :line2,               :null => true
      t.string    :city,                :null => false
      t.string    :state_cd,            :null => false, :limit => 2
      t.string    :zip,                 :null => false, :limit => 5
    end
  end

  def self.down
    drop_table :addresses
  end
end
