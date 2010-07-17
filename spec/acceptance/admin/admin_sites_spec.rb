require File.dirname(__FILE__) + '/../acceptance_spec_helper' 

describe "Admin" do 
 include AcceptanceSpecHelper

 before :each do
   browser.goto :main_menu_link_admin
 end

 describe "Sites" do
   before :each do
     @site = Factory.create(:site)

     @empty_site = Factory.create(:site)
#     @site_with_event = Factory.create(:event).site

     study = Factory.create(:study)
     @site_from_study = Factory.create(:site)
     study.sites << @site_from_study
     study.save!

     @site_to_edit = Factory.create(:site)

     browser.goto :main_menu_link_admin_sites
   end

   
   it "Add" do 
      site = Factory.build(:site)

      browser.ajax :add_site
      browser.type :site_name, site.name
      browser.type :site_number, site.name
      browser.type :site_investigator, site.investigator
      browser.type :site_address_1, site.address_1
      browser.type :site_city, site.city
      browser.type :site_state_cd, site.state_cd
      browser.type :site_zip, site.zip
      browser.select :site_time_zone, "value=#{site.time_zone}"
      browser.ajax :site_submit

      Site.find_by_name(site.name).should_not be_nil
   end

   describe "Delete" do
     it "Available for standalone site" do
       browser.ajax "delete_site_#{@empty_site.id}"

       Site.find_by_id(@empty_site.id).should be_nil
     end

     #it "Not available for the site with events" do
     #  browser.element?("delete_site_#{@site_with_event.id}").should be_false
     #end

     it "Not available fot the site that is included to some study" do
       browser.element?("delete_site_#{@site_from_study.id}").should be_false
     end
   end

   it "Edit" do
      site = Factory.build(:site)
      
      browser.ajax "edit_site_#{@site_to_edit.id}"

      browser.type :site_name, site.name
      browser.type :site_number, site.name
      browser.type :site_investigator, site.investigator
      browser.type :site_address_1, site.address_1
      browser.type :site_city, site.city
      browser.type :site_state_cd, site.state_cd
      browser.type :site_zip, site.zip
      browser.select :site_time_zone, "value=#{site.time_zone}"
   end

   describe "Show" do
     before :each do
       @user_to_add = Factory.create(:user)
       @user_to_remove = Factory.create(:user)

       @site.contacts << @user_to_remove
       @site.save!

       browser.ajax "show_site_#{@site.id}"
     end

     describe "Contacts" do
       before :each do
         browser.ajax "contacts_site_#{@site.id}"
       end

       it "Add existing" do 
         browser.ajax "add_contact_site_#{@site.id}" 
         browser.add_selection "contacts_", "value=#{@user_to_add.id}"
         browser.ajax "add_contact_submit_site_#{@site.id}" 

         @site.reload.contacts.find_by_id(@user_to_add.id).should_not be_nil
       end

       describe "Create new" do
         before :each do
           browser.ajax "new_contact_site_#{@site.id}" 
         end

         it_should_behave_like "UserInputForm"
       end

       it "Delete" do 
         browser.ajax "remove_user_#{@user_to_remove.id}_site_#{@site.id}"

         @site.reload.contacts.find_by_id(@user_to_remove.id).should be_nil
       end
     end
   end
 end
end
