require File.dirname(__FILE__) + '/../acceptance_spec_helper' 

describe "Admin" do 
 include AcceptanceSpecHelper

 before :each do
   browser.goto :main_menu_link_admin
 end

 describe "Studies" do
   before :each do
     @study = Factory.create(:study) 
     browser.goto :main_menu_link_admin_studies
   end

   it "Add" do 
     study = Factory.build(:study)

     browser.ajax :add_study     
     browser.type :study_name, study.name
     browser.type :study_protocol_number, study.protocol_number
     browser.type :study_title, study.title
     browser.type :study_drug_name, study.drug_name
     browser.type :study_auto_therapeutic_area_name, study.therapeutic_area
     browser.type :study_fpfv, study.fpfv 
     browser.type :study_lplv, study.lplv 
     browser.type :study_expected_db_lock, study.expected_db_lock
     browser.type "study_expected_sites_number", study.expected_sites_number
     browser.ajax :study_submit

     Study.find_by_name(study.name).should_not be_nil
   end

   describe "Show" do
     before :each do
       @absolute_visit = Factory.create(:visit_absolute, :study => @study)
       @visit_to_delete = Factory.create(:visit_absolute, :study => @study)

       @user_to_delete = Factory.create(:user)
       @study.contacts << @user_to_delete
       @site_to_delete = Factory.create(:site)
       @study.sites << @site_to_delete
       @site = Factory.create(:site)
       @study.sites << @site
       @study_site_user_to_delete = Factory.create(:user)
       @site.contacts << @study_site_user_to_delete 
       @study.site_users << @site.site_users 
       @study.save!


       browser.ajax "show_study_#{@study.id}"
     end

     describe "Sites" do
       before :each do
         browser.ajax "sites_study_#{@study.id}"
       end

       it "Add" do
         site = Factory.create(:site)

         browser.ajax "add_site_study_#{@study.id}" 
         browser.add_selection "sites_", "value=#{site.id}"
         browser.ajax "add_site_submit_study_#{@study.id}" 

         @study.reload.sites.find_by_id(site.id).should_not be_nil
       end

       it "Remove" do
         browser.ajax "remove_site_#{@site_to_delete.id}_study_#{@study.id}"

         @study.reload.sites.find_by_id(@site_to_delete.id).should be_nil
       end

       describe "Show" do
         before :each do
           browser.ajax "show_site_#{@site.id}_study_#{@study.id}"
         end

         describe "Coordinators" do
           it "Add" do
             user = Factory.create(:user)
             @site.contacts << user
             @site.save!

             site_user = SiteUser.find_by_site_id_and_user_id @site.id, user.id

             browser.ajax "add_contact_site_#{@site.id}_study_#{@study.id}"
             browser.add_selection "site_contacts_", "value=#{site_user.id}"
             browser.ajax "add_contact_submit_site_#{@site.id}_study_#{@study.id}"

             @study.site_users.find_by_id(site_user.id).should_not be_nil
           end

           it "Delete" do
             browser.ajax "remove_user_#{@study_site_user_to_delete.id}_site_#{@site.id}"
             
             @study.reload.site_users.find_by_id(@study_site_user_to_delete.id).should be_nil
           end
         end
       end
     end

     describe "Contacts" do
       before :each do
         browser.ajax "contacts_study_#{@study.id}"
       end

       it "Add existing" do
         user = Factory.create(:user)

         browser.ajax "add_contact_study_#{@study.id}" 
         browser.add_selection "contacts_", "value=#{user.id}"
         browser.ajax "add_contact_submit_study_#{@study.id}" 

         @study.reload.contacts.find_by_id(user.id).should_not be_nil
       end

       it "Delete" do
         browser.ajax "remove_user_#{@user_to_delete.id}_study_#{@study.id}"

         @study.reload.contacts.find_by_id(@user_to_delete.id).should be_nil
       end

       describe "Create new" do
         before :each do
           browser.ajax "new_contact_study_#{@study.id}" 
         end

         it_should_behave_like "UserInputForm"
       end
     end

     describe "Visits" do
       before :each do
         browser.ajax "visits_study_#{@study.id}"
       end

       describe "Create" do
         before :each do
           browser.ajax "add_visit_study_#{@study.id}"

           @visit = Factory.build(:visit)

           browser.type :visit_name, @visit.name
           browser.type :visit_number, @visit.number
           browser.type :visit_notes, @visit.notes
         end

         it "Absolute" do
           visit = Factory.build(:visit_absolute, :study => @study)

           browser.click :relative_visit_false
           browser.type :visit_start_date, visit.start_date
           browser.type :visit_end_date, visit.end_date
           browser.ajax :visit_submit

           @study.visits.find_by_number(@visit.number).should_not be_nil
         end

         it "Relative" do
           visit = Factory.build(:visit_relative, :study => @study, :prev_visit => @absolute_visit)

           browser.click :relative_visit_true
           browser.select :visit_prev_visit_id, "value=#{visit.prev_visit_id}"
           browser.type :visit_prev_visit_start_offset_day, visit.prev_visit_start_offset_day
           browser.type :visit_prev_visit_end_offset_day, visit.prev_visit_end_offset_day
           browser.ajax :visit_submit
           browser.wait_for_ajax

           @study.visits.find_by_number(@visit.number).should_not be_nil
         end
       end

       it "Delete" do
         browser.ajax "delete_visit_#{@visit_to_delete.id}_study_#{@study.id}"

         @study.visits.find_by_number(@visit_to_delete.number).should be_nil
       end
     end
   end
 end
end
