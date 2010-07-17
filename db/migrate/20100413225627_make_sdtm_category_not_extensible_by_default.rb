class MakeSdtmCategoryNotExtensibleByDefault < ActiveRecord::Migration
  def self.up
    change_column :sdtm_categories, :extensible, :boolean, :null => false, :default => false 
  end

  def self.down
    change_column :sdtm_categories, :extensible, :boolean, :null => false
  end
end
