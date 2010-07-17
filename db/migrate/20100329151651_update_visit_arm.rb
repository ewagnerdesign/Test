class UpdateVisitArm < ActiveRecord::Migration
  def self.up
    remove_column :visit_arms, :default
  end

  def self.down
    add_column :visit_arms, :default, :boolean, :null => false
  end
end
