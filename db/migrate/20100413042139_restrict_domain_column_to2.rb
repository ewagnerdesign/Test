class RestrictDomainColumnTo2 < ActiveRecord::Migration
  def self.up
    change_column :domains, :code, :string, :limit => 2, :null => false
  end

  def self.down
    change_column :domains, :code, :limit => 255, :null => false
  end
end
