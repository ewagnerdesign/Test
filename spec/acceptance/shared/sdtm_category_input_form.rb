shared_examples_for "SdtmCategoryInputForm" do
  before :all do
    @sdtm_parent = Factory.build(:sdtm_category)
  end

  it "Allows to enter & save SDTM Parent data" do

    browser.type :sdtm_category_code, @sdtm_parent.code 
    browser.type :sdtm_category_name, @sdtm_parent.name
    browser.type :sdtm_category_submission_value, @sdtm_parent.submission_value 
    browser.type :sdtm_category_cdisc_preferred_term, @sdtm_parent.cdisc_preferred_term
    browser.type :sdtm_category_synonyms, @sdtm_parent.synonyms
    browser.type :sdtm_category_definition, @sdtm_parent.definition
    browser.type :sdtm_category_nci_preferred_term, @sdtm_parent.nci_preferred_term

    browser.ajax :sdtm_category_submit

    saved_parent = SdtmCategory.find_by_code(@sdtm_parent.code)
    
    saved_parent.should_not be_nil
    saved_parent.name.should == @sdtm_parent.name
    saved_parent.submission_value.should == @sdtm_parent.submission_value
    saved_parent.cdisc_preferred_term.should == @sdtm_parent.cdisc_preferred_term
    saved_parent.synonyms.should == @sdtm_parent.synonyms
    saved_parent.definition.should == @sdtm_parent.definition
    saved_parent.nci_preferred_term.should == @sdtm_parent.nci_preferred_term
    saved_parent.read_only.should be_false
    saved_parent.extensible.should be_true
  end
end
