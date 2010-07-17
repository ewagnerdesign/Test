require 'spec_helper'

module TrovareSpecHelper
  def clean_tables *tables
    tables.each do |table_name|
      ActiveRecord::Base.connection.update "truncate #{table_name}"
    end
  end

#  def clean_table table_name, opts={}
#    method = opts
#  end

  def clean_db
    ActiveRecord::Base.connection.delete "delete from visits where prev_visit_id is not null "
    ActiveRecord::Base.connection.delete "delete from cdash_questions where variable_name like '__cdash_question_%_variable_name'"
    ActiveRecord::Base.connection.delete "delete from sdtm_answers where code like '__sdtm_answer_%_code'"
    ActiveRecord::Base.connection.delete "delete from sdtm_categories where code like '__sdtm_category_%_code'"
    ActiveRecord::Base.connection.delete "delete from domains where name like 'Name %'"

    clean_tables :form_fields, 
                 :forms,
                 :study_site_users,
                 :site_users,
                 :study_users,
                 :subjects,
                 :study_arm_visits,
                 :study_arms,
                 :study_sites,
                 :subjects,
                 :visits,
                 :studies,
                 :sites

    ActiveRecord::Base.connection.delete "delete from users where login like '__trovare%'"
  end
end
