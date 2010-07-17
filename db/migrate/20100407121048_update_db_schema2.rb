class UpdateDbSchema2 < ActiveRecord::Migration
  def self.up
    change_column :visits, :study_id, :int, :null => false

    remove_column :studies, :sponsor_id
    change_column :studies, :protocol_number, :string, :limit => 255, :null => false
    change_column :studies, :name, :string, :limit => 255, :null => false
    change_column :studies, :drug_name, :string, :limit => 255, :null => false
    change_column :studies, :therapeutic_area_id, :int, :null => false

    add_column :studies, :default_study_arm_id, :int, :null => true

    change_column :study_sites, :study_id, :int, :null => false
    change_column :study_sites, :site_id, :int, :null => false

    change_column :subjects, :code, :string, :limit => 255, :null => false
    change_column :subjects, :study_id, :int, :null => false

    remove_column :events, :visit_date
    change_column :events, :site_id, :int, :null => false
    change_column :events, :subject_id, :int, :null => false
    change_column :events, :study_id, :int, :null => false

    change_column :form_instances, :form_id, :int, :null => false

    add_column :forms, :domain_id, :int, :null => true
    change_column :forms, :name, :string, :limit => 255, :null => false
    change_column :forms, :metadata, :text, :null => false

    change_column :form_field_values, :form_instance_id, :int, :null => false
    change_column :form_field_values, :form_field_id, :int, :null => false

    change_column :site_users, :site_id, :int, :null => false
    change_column :site_users, :user_id, :int, :null => false

    change_column :study_users, :study_id, :int, :null => false
    change_column :study_users, :user_id, :int, :null => false

    change_column :study_site_users, :study_id, :int, :null => false
    change_column :study_site_users, :site_user_id, :int, :null => false

    change_column :users, :first_name, :string, :limit => 255, :null => false
    change_column :users, :last_name, :string, :limit => 255, :null => false
    change_column :users, :title, :string, :limit => 255, :null => false
  end

  def self.down
    change_column :visits, :study_id, :int, :null => true

    add_column :studies, :sponsor_id, :int
    change_column :studies, :protocol_number, :string, :limit => 255 , :null => true
    change_column :studies, :name, :string, :limit => 255 , :null => true
    change_column :studies, :drug_name, :string, :limit => 255 , :null => true
    change_column :studies, :therapeutic_area_id, :int, :null => true

    remove_column :studies, :default_study_arm_id

    change_column :study_sites, :study_id, :int, :null => true
    change_column :study_sites, :site_id, :int, :null => true

    change_column :subjects, :code, :string, :limit => 255 , :null => true
    change_column :subjects, :study_id, :int, :null => true

    add_column :events, :visit_date, :date, :null => true
    change_column :events, :site_id, :int, :null => true
    change_column :events, :subject_id, :int, :null => true
    change_column :events, :study_id, :int, :null => true

    change_column :form_instances, :form_id, :int, :null => true
    
    remove_column :forms, :domain_id
    change_column :forms, :name, :string, :limit => 255, :null => true
    change_column :forms, :metadata, :text, :null => true

    change_column :form_field_values, :form_instance_id, :int, :null => true
    change_column :form_field_values, :form_field_id, :int, :null => true

    change_column :site_users, :site_id, :int, :null => true
    change_column :site_users, :user_id, :int, :null => true

    change_column :study_users, :study_id, :int, :null => true
    change_column :study_users, :user_id, :int, :null => true
    
    change_column :study_site_users, :study_id, :int, :null => true
    change_column :study_site_users, :site_user_id, :int, :null => true

    change_column :users, :first_name, :string, :limit => 255, :null => true
    change_column :users, :last_name, :string, :limit => 255, :null => true
    change_column :users, :title, :string, :limit => 255, :null => true
  end
end
