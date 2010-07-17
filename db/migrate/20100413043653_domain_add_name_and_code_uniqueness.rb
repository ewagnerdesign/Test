class DomainAddNameAndCodeUniqueness < ActiveRecord::Migration
  def self.up
    add_index :domains, :code, :unique => true
    add_index :domains, :name, :unique => true
  end

  def self.down
    remove_index :domains, :code
    remove_index :domains, :name
  end
end
