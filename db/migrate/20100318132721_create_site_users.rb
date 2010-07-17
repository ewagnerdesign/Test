class CreateSiteUsers < ActiveRecord::Migration
  def self.up
    create_table :site_users do |t|
      t.integer :site_id
      t.integer :user_id

      t.timestamps
    end

    remove_column :users, :site_id
  end

  def self.down
    drop_table :site_users

    add_column :users, :site_id, :integer
  end
end
