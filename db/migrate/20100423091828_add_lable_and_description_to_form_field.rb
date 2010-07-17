class AddLableAndDescriptionToFormField < ActiveRecord::Migration
  def self.up
    add_column :form_fields, :label, :string
    add_column :form_fields, :description, :string
  end

  def self.down
    remove_column :form_fields, :description
    remove_column :form_fields, :label
  end
end
