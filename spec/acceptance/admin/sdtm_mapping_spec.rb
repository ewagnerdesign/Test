require File.dirname(__FILE__) + '/../acceptance_spec_helper' 

describe "Admin" do 
  include AcceptanceSpecHelper

  before :each do
    browser.goto :main_menu_link_admin
  end

  describe "SDTM Category" do
    before :each do
      @sdtm_category_to_delete = Factory.create(:sdtm_category)
      @sdtm_category_read_only = Factory.create(:sdtm_category_read_only)
      
      sdtm_answer = Factory.create(:sdtm_answer)
      @sdtm_category_with_sdtm_answer = sdtm_answer.sdtm_category

      form_field = Factory.build(:form_field)
      @sdtm_category_with_form_field = Factory.create(:sdtm_category)
      form_field.sdtm_category = @sdtm_category_with_form_field
      form_field.save!
      
      cdash_question = Factory.create(:cdash_question)
      @sdtm_category_with_cdash_question = cdash_question.sdtm_category

    #  @sdtm_category_to_show = Factory.create(:sdtm_category)

      browser.goto :main_menu_link_sdtm_category
    end

    describe "Create Parent" do
      before :each do
        browser.ajax :create_sdtm_parent
      end

      it_should_behave_like "SdtmCategoryInputForm"
    end

    describe "Delete Parent" do
      it "Available for not read only category" do
        browser.ajax "delete_sdtm_category_#{@sdtm_category_to_delete.id}"
        browser.confirm()

        SdtmCategory.find_by_id(@sdtm_category_to_delete).should be_nil
      end

      describe "Not available if category " do
        it "is read only" do
          browser.element?("delete_sdtm_category_#{@sdtm_category_read_only.id}").should be_false
        end

        it "has sdtm answers" do
          browser.element?("delete_sdtm_category_#{@sdtm_category_with_sdtm_answer.id}").should be_false
        end

        it "is referenced by form fields" do
          browser.element?("delete_sdtm_category_#{@sdtm_category_with_form_field.id}").should be_false
        end

        it "has cdash questions" do
          browser.element?("delete_sdtm_category_#{@sdtm_category_with_cdash_question.id}").should be_false
        end
      end
    end

    describe "Edit" do
      it "Not available for read only category" do
        browser.element?("edit_sdtm_category_#{@sdtm_category_read_only.id}").should be_false
      end

      describe "Available for writable category" do
        before :each do
          
        end
      end
    end
  end
end
