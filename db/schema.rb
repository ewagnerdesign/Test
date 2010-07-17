# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100624171208) do

  create_table "cdash_questions", :force => true do |t|
    t.string   "data_collection_field",   :null => false
    t.integer  "domain_id",               :null => false
    t.integer  "number",                  :null => false
    t.string   "variable_name",           :null => false
    t.text     "definition",              :null => false
    t.text     "completion_instructions"
    t.text     "sponsor_info"
    t.string   "core",                    :null => false
    t.integer  "sdtm_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cdash_questions", ["domain_id"], :name => "fk_cdash_questions_domain_id"
  add_index "cdash_questions", ["sdtm_category_id"], :name => "fk_cdash_questions_sdtm_category_id"
  add_index "cdash_questions", ["variable_name"], :name => "index_cdash_questions_on_variable_name", :unique => true

  create_table "changes_history", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "auditable_lock_version"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "changes"
    t.integer  "version",                :default => 0
    t.datetime "created_at"
    t.boolean  "visible",                :default => true, :null => false
  end

  add_index "changes_history", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "changes_history", ["created_at"], :name => "index_changes_history_on_created_at"
  add_index "changes_history", ["user_id", "user_type"], :name => "user_index"

  create_table "domains", :force => true do |t|
    t.string   "code",         :limit => 2, :null => false
    t.string   "name",                      :null => false
    t.string   "domain_class",              :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["code"], :name => "index_domains_on_code", :unique => true
  add_index "domains", ["name"], :name => "index_domains_on_name", :unique => true

  create_table "form_field_monitor_views", :force => true do |t|
    t.integer  "form_field_id",   :null => false
    t.integer  "monitor_view_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_field_values", :force => true do |t|
    t.integer  "form_instance_id",                    :null => false
    t.integer  "form_field_id",                       :null => false
    t.text     "value"
    t.string   "override_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version"
    t.boolean  "monitored",        :default => false, :null => false
  end

  create_table "form_fields", :force => true do |t|
    t.text     "validators"
    t.text     "field_type"
    t.text     "options"
    t.integer  "sdtm_category_id"
    t.integer  "cdash_question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
    t.string   "description"
    t.integer  "form_version_id",   :null => false
    t.integer  "field_id"
  end

  add_index "form_fields", ["field_id"], :name => "index_form_fields_on_field_id"
  add_index "form_fields", ["form_version_id"], :name => "fk_form_fields_form_version_id"

  create_table "form_instances", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_id"
    t.integer  "lock_version"
    t.boolean  "submitted"
    t.integer  "submitted_by_id"
    t.datetime "submitted_at"
    t.integer  "visit_id"
    t.datetime "actual_date_time"
    t.integer  "form_version_id",  :null => false
  end

  add_index "form_instances", ["form_version_id"], :name => "fk_form_instances_form_version_id"

  create_table "form_study_arm_visits", :force => true do |t|
    t.integer  "form_id",            :null => false
    t.integer  "study_arm_visit_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "form_study_arm_visits", ["form_id", "study_arm_visit_id"], :name => "index_form_study_arm_visits_on_form_id_and_study_arm_visit_id", :unique => true
  add_index "form_study_arm_visits", ["study_arm_visit_id"], :name => "fk_form_study_arm_visits_study_arm_visit_id"

  create_table "form_versions", :force => true do |t|
    t.integer  "form_id"
    t.text     "metadata",                                      :null => false
    t.text     "html"
    t.string   "name",          :limit => 45,                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "just_created",                :default => true, :null => false
    t.integer  "created_by_id",                                 :null => false
  end

  add_index "form_versions", ["created_by_id"], :name => "fk_form_versions_created_by_id"

  create_table "forms", :force => true do |t|
    t.string   "name",                           :null => false
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "domain_id"
    t.boolean  "cumulative",  :default => false, :null => false
  end

  create_table "login_attempts", :force => true do |t|
    t.string   "login"
    t.integer  "user_id"
    t.string   "ip",          :limit => 15, :null => false
    t.string   "user_agent",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "successfull",               :null => false
  end

  add_index "login_attempts", ["user_id"], :name => "fk_login_attempts_user_id"

  create_table "monitor_views", :force => true do |t|
    t.string   "name",       :limit => 45
    t.integer  "study_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "form_id",                  :null => false
  end

  add_index "monitor_views", ["form_id"], :name => "fk_monitor_views_form_id"

  create_table "old_passwords", :force => true do |t|
    t.string   "crypted_password", :null => false
    t.string   "password_salt",    :null => false
    t.integer  "user_id",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "old_passwords", ["user_id"], :name => "index_old_passwords_on_user_id"

  create_table "permission_roles", :force => true do |t|
    t.integer  "permission_id", :null => false
    t.integer  "role_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permission_roles", ["permission_id", "role_id"], :name => "index_permission_roles_on_permission_id_and_role_id", :unique => true
  add_index "permission_roles", ["role_id"], :name => "fk_permission_roles_role_id"

  create_table "permissions", :force => true do |t|
    t.string   "name",        :limit => 100, :null => false
    t.string   "description",                :null => false
    t.integer  "category",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["name"], :name => "index_permissions_on_name", :unique => true

  create_table "queries", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment",                                :null => false
    t.integer  "user_id",                                :null => false
    t.integer  "form_field_value_id",                    :null => false
    t.integer  "lock_version"
    t.boolean  "closed",              :default => false, :null => false
    t.integer  "closed_by_id"
  end

  create_table "query_comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "query_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query_type",   :null => false
    t.string   "query_action"
  end

  create_table "role_site_users", :force => true do |t|
    t.integer  "role_id",      :null => false
    t.integer  "site_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_site_users", ["role_id", "site_user_id"], :name => "index_role_site_users_on_role_id_and_site_user_id", :unique => true
  add_index "role_site_users", ["site_user_id"], :name => "fk_role_site_users_site_user_id"

  create_table "role_study_site_users", :force => true do |t|
    t.integer  "role_id",            :null => false
    t.integer  "study_site_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_study_site_users", ["role_id", "study_site_user_id"], :name => "index_role_study_site_users_on_role_id_and_study_site_user_id", :unique => true
  add_index "role_study_site_users", ["study_site_user_id"], :name => "fk_role_study_site_users_study_site_user_id"

  create_table "role_study_users", :force => true do |t|
    t.integer  "role_id",       :null => false
    t.integer  "study_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_study_users", ["role_id", "study_user_id"], :name => "index_role_study_users_on_role_id_and_study_user_id", :unique => true
  add_index "role_study_users", ["study_user_id"], :name => "fk_role_study_users_study_user_id"

  create_table "role_users", :force => true do |t|
    t.integer  "role_id",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_users", ["role_id", "user_id"], :name => "index_role_users_on_role_id_and_user_id", :unique => true
  add_index "role_users", ["user_id"], :name => "fk_role_users_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name",        :limit => 45, :null => false
    t.string   "description",               :null => false
    t.integer  "category",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "sdtm_answers", :force => true do |t|
    t.string   "code",                 :limit => 45,                   :null => false
    t.string   "submission_value",                                     :null => false
    t.string   "cdisc_preferred_term",                                 :null => false
    t.string   "synonyms",                                             :null => false
    t.text     "definition"
    t.string   "nci_preferred_term",                                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sdtm_category_id",                                     :null => false
    t.boolean  "read_only",                          :default => true, :null => false
  end

  add_index "sdtm_answers", ["sdtm_category_id", "code"], :name => "index_sdtm_answers_on_sdtm_category_id_and_code", :unique => true

  create_table "sdtm_categories", :force => true do |t|
    t.string   "code",                 :limit => 45,                    :null => false
    t.boolean  "extensible",                         :default => false, :null => false
    t.string   "name",                                                  :null => false
    t.string   "submission_value",                                      :null => false
    t.string   "cdisc_preferred_term",                                  :null => false
    t.string   "synonyms",                                              :null => false
    t.text     "definition"
    t.string   "nci_preferred_term",                                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read_only",                          :default => true,  :null => false
  end

  add_index "sdtm_categories", ["code"], :name => "index_sdtm_categories_on_code", :unique => true

  create_table "settings", :force => true do |t|
    t.string   "var",        :null => false
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["var"], :name => "index_settings_on_var"

  create_table "site_study_users", :force => true do |t|
    t.integer  "study_user_id", :null => false
    t.integer  "site_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_study_users", ["site_id", "study_user_id"], :name => "index_site_study_users_on_site_id_and_study_user_id", :unique => true
  add_index "site_study_users", ["study_user_id"], :name => "fk_site_study_users_study_user_id"

  create_table "site_users", :force => true do |t|
    t.integer  "site_id",                               :null => false
    t.integer  "user_id",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "study_site_users_count", :default => 0
  end

  add_index "site_users", ["site_id", "user_id"], :name => "index_site_users_on_site_id_and_user_id", :unique => true
  add_index "site_users", ["user_id"], :name => "fk_site_users_user_id"

  create_table "sites", :force => true do |t|
    t.string   "name",         :limit => 45,                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number",       :limit => 45
    t.string   "investigator", :limit => 45
    t.boolean  "active",                     :default => true, :null => false
    t.string   "address_1",                                    :null => false
    t.string   "address_2"
    t.string   "city",         :limit => 45,                   :null => false
    t.string   "state_cd",     :limit => 2,                    :null => false
    t.string   "zip",          :limit => 5,                    :null => false
    t.integer  "lock_version"
    t.string   "time_zone"
    t.string   "phone",        :limit => 10
    t.string   "ext",          :limit => 5
    t.string   "fax",          :limit => 10
  end

  add_index "sites", ["name"], :name => "index_sites_on_name", :unique => true

  create_table "studies", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                                                 :null => false
    t.string   "protocol_number",                                       :null => false
    t.string   "name",                  :limit => 45,                   :null => false
    t.string   "drug_name",                                             :null => false
    t.date     "fpfv"
    t.date     "lplv"
    t.date     "expected_db_lock"
    t.integer  "expected_sites_number"
    t.boolean  "active",                              :default => true, :null => false
    t.integer  "therapeutic_area_id",                                   :null => false
    t.integer  "default_study_arm_id"
  end

  add_index "studies", ["name"], :name => "index_studies_on_name", :unique => true
  add_index "studies", ["therapeutic_area_id"], :name => "fk_studies_therapeutic_area_id"

  create_table "study_arm_visits", :force => true do |t|
    t.integer  "study_arm_id", :null => false
    t.integer  "visit_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_arm_visits", ["study_arm_id", "visit_id"], :name => "index_study_arm_visits_on_study_arm_id_and_visit_id", :unique => true
  add_index "study_arm_visits", ["visit_id"], :name => "fk_study_arm_visits_visit_id"

  create_table "study_arms", :force => true do |t|
    t.string   "code",       :limit => 45, :null => false
    t.integer  "study_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_arms", ["study_id", "code"], :name => "index_study_arms_on_study_id_and_code", :unique => true

  create_table "study_forms", :force => true do |t|
    t.integer  "study_id",   :null => false
    t.integer  "form_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_forms", ["form_id", "study_id"], :name => "index_study_forms_on_form_id_and_study_id", :unique => true
  add_index "study_forms", ["study_id"], :name => "fk_study_forms_study_id"

  create_table "study_site_form_versions", :force => true do |t|
    t.boolean  "accepted",        :default => false, :null => false
    t.integer  "study_site_id",                      :null => false
    t.integer  "form_version_id",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_site_form_versions", ["form_version_id"], :name => "fk_study_site_form_versions_form_version_id"
  add_index "study_site_form_versions", ["study_site_id", "form_version_id"], :name => "study_site_form_versions_assocs", :unique => true

  create_table "study_site_users", :force => true do |t|
    t.integer  "study_id",     :null => false
    t.integer  "site_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_site_users", ["site_user_id"], :name => "fk_study_site_users_site_user_id"
  add_index "study_site_users", ["study_id", "site_user_id"], :name => "index_study_site_users_on_study_id_and_site_user_id", :unique => true

  create_table "study_sites", :force => true do |t|
    t.integer  "study_id",   :null => false
    t.integer  "site_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_sites", ["site_id"], :name => "fk_study_sites_site_id"
  add_index "study_sites", ["study_id", "site_id"], :name => "index_study_sites_on_study_id_and_site_id", :unique => true

  create_table "study_users", :force => true do |t|
    t.integer  "study_id",   :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_users", ["study_id", "user_id"], :name => "index_study_users_on_study_id_and_user_id", :unique => true
  add_index "study_users", ["user_id"], :name => "fk_study_users_user_id"

  create_table "subjects", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "study_id",                                             :null => false
    t.integer  "study_arm_id",                                         :null => false
    t.integer  "number",                                               :null => false
    t.integer  "randomization_number"
    t.string   "gender",               :limit => 0,                    :null => false
    t.date     "dob",                                                  :null => false
    t.datetime "consent_datetime",                                     :null => false
    t.boolean  "inactive",                          :default => false, :null => false
    t.integer  "site_id",                                              :null => false
  end

  add_index "subjects", ["study_arm_id"], :name => "fk_subjects_study_arm_id"
  add_index "subjects", ["study_id", "number"], :name => "index_subjects_on_study_id_and_number", :unique => true

  create_table "therapeutic_areas", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email",                                              :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                                  :null => false
    t.string   "perishable_token",                                   :null => false
    t.integer  "login_count",                      :default => 0,    :null => false
    t.integer  "failed_login_count",               :default => 0,    :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",   :limit => 15
    t.string   "last_login_ip",      :limit => 15
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                                         :null => false
    t.string   "last_name",                                          :null => false
    t.string   "middle_name"
    t.string   "title",                                              :null => false
    t.string   "address_1",                                          :null => false
    t.string   "address_2"
    t.string   "city",               :limit => 45,                   :null => false
    t.string   "state_cd",           :limit => 2,                    :null => false
    t.string   "zip",                :limit => 5,                    :null => false
    t.string   "phone",              :limit => 10
    t.string   "fax",                :limit => 10
    t.string   "web_site"
    t.boolean  "active",                           :default => true, :null => false
    t.string   "ext",                :limit => 5
    t.string   "time_zone",                                          :null => false
    t.boolean  "site_user",                        :default => true, :null => false
    t.boolean  "first_login",                      :default => true
    t.datetime "login_locked"
  end

  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "visits", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number",                      :limit => 45, :null => false
    t.string   "name",                                      :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.text     "notes"
    t.integer  "study_id",                                  :null => false
    t.integer  "prev_visit_start_offset_day"
    t.integer  "prev_visit_end_offset_day"
    t.integer  "prev_visit_id"
    t.string   "status",                      :limit => 45
  end

  add_index "visits", ["prev_visit_id"], :name => "fk_visits_prev_visit_id"
  add_index "visits", ["study_id", "name"], :name => "index_visits_on_study_id_and_name", :unique => true
  add_index "visits", ["study_id", "number"], :name => "index_visits_on_study_id_and_number", :unique => true

end
