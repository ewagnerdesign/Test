require File.dirname(__FILE__) + '/../acceptance_spec_helper' 

describe "Admin" do 
  include AcceptanceSpecHelper

  before :each do
    browser.goto :main_menu_link_admin
  end

  describe "Users" do
    before :each do
      @user_to_delete = Factory.create(:user)
      @user_to_edit = Factory.create(:user)
      browser.goto :main_menu_link_users
    end

    describe "Add" do
      before :each do
        browser.ajax :add_user
      end

      it_should_behave_like "UserInputForm"
    end

    describe "Edit" do
      before :each do
        browser.ajax "edit_user_#{@user_to_edit.id}"
      end

      it_should_behave_like "UserInputForm"
    end

    it "Delete" do
      browser.ajax "delete_user_#{@user_to_delete.id}"

      User.find_by_id(@user_to_delete.id).should be_nil
    end
 end
end
