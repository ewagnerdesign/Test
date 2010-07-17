class AddChangesHistoryTable < ActiveRecord::Migration
  def self.up
    create_table :changes_history, :force => true do |t|
      t.column :auditable_id, :integer
      t.column :auditable_type, :string
      t.column :auditable_lock_version, :integer
      t.column :user_id, :integer
      t.column :user_type, :string
      t.column :username, :string
      t.column :action, :string
      t.column :changes, :text
      t.column :version, :integer, :default => 0
      t.column :created_at, :datetime
    end
    
    add_index :changes_history, [:auditable_id, :auditable_type], :name => 'auditable_index'
    add_index :changes_history, [:user_id, :user_type], :name => 'user_index'
    add_index :changes_history, :created_at  
  end

  def self.down
    drop_table :changes_history
  end
end
