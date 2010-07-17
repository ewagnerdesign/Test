class AddStatusToVisit < ActiveRecord::Migration
  def self.up
    add_column :visits, :status, :string
  end

  def self.down
    remove_column :visits, :status
  end
end
