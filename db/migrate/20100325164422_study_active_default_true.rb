class StudyActiveDefaultTrue < ActiveRecord::Migration
  def self.up
    change_column :studies, :active, :boolean, :default => true, :null => false
  end

  def self.down
    change_column :studies, :active, :boolean, :default => false, :null => false
  end
end

