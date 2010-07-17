class ROforSdtmsAndCdashes < ActiveRecord::Migration
  def self.up
    add_column :sdtms, :read_only, :boolean, :default => true, :null => false
    add_column :cdashes, :read_only, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :sdtms, :read_only
    remove_column :cdashes, :read_only
  end
end
