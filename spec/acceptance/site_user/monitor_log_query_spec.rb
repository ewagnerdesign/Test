require File.dirname(__FILE__) + '/../acceptance_spec_helper' 
#require File.dirname(__FILE__) + '/../../support/create_or_load'

describe "Monitor query" do 
 include AcceptanceSpecHelper

 it "log without errors" do 
   pending
   #create form_instance
   Factory.create(:user_monitor)
   Factory.create(:user_investigator)

   #create form_field_value
   form_field_value = Factory.load_or_create(:form_field_value)

   browser.open "/user_session/new"                                                                                                                                                                                         
   browser.wait_for_page_to_load 
   browser.type :user_session_login, "monitor"
   browser.type :user_session_password, "monitor"
   browser.click :user_session_submit
   browser.wait_for_page_to_load 
   browser.click :main_menu_link_queries
   browser.wait_for_page_to_load 
#   browser.click :add_new_query
 end
end
