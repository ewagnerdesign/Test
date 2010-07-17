class AddColumnsToSubject < ActiveRecord::Migration
  def self.up
    add_column :subjects, :randomization_number, :integer
    add_column :subjects, :screen_number, :integer
    add_column :subjects, :status, :string
    add_column :subjects, :status_date, :date
  end

  def self.down
    remove_column :subjects, :status_date
    remove_column :subjects, :status
    remove_column :subjects, :screen_number
    remove_column :subjects, :randomization_number
  end
end
