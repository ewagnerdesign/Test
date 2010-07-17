require File.dirname(__FILE__) + '/../acceptance_spec_helper' 

describe "Site User" do 
 include AcceptanceSpecHelper

 describe "Subjects" do
   before :each do
     @study = Factory.create(:study)
     @study_arm = Factory.create(:study_arm, :study => @study)
     @subject_to_delete = Factory.create(:subject, :study => @study, :study_arm => @study_arm)

     browser.goto :main_menu_link_subjects
     browser.goto "select_study_#{@study.id}" 
   end

   it "Create" do 
     subj = Factory.build(:subject, :study_arm => @study_arm)

     browser.ajax :add_subject
     browser.select :subject_study_id, "value=#{@study.id}"
     browser.select :subject_study_arm_id, "value=#{@study_arm.id}"
     browser.type :subject_number, subj.number 
     browser.type :subject_randomization_number, subj.randomization_number 
     browser.select :subject_gender, "value=#{subj.gender}"
     browser.type :subject_dob, subj.dob
     browser.type :subject_consent_datetime_fake, subj.consent_datetime
     browser.ajax :subject_submit

     Subject.find_by_number(subj.number).should_not be_nil
   end

   it "Delete" do 
     browser.ajax "delete_subject_#{@subject_to_delete.id}"
     browser.confirm()

     Subject.find_by_number(@subject_to_delete.number).should be_nil
   end
 end
end
