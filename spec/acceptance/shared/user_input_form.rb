shared_examples_for "UserInputForm" do
  it "Active user" do
    @user_to_add = Factory.build(:user)

    browser.type :user_login, @user_to_add.login
    browser.type :user_first_name, @user_to_add.first_name
    browser.type :user_middle_name, @user_to_add.middle_name
    browser.type :user_last_name, @user_to_add.last_name
    browser.type :user_title, @user_to_add.title
    browser.type :user_email, @user_to_add.email
    browser.type :user_address_1, @user_to_add.address_1
    browser.type :user_address_2, @user_to_add.address_2
    browser.type :user_city, @user_to_add.city
    browser.type :user_state_cd, @user_to_add.state_cd
    browser.type :user_zip, @user_to_add.zip
    browser.type :user_phone, @user_to_add.phone
    browser.type :user_ext, @user_to_add.ext
    browser.type :user_fax, @user_to_add.fax
    browser.type :user_web_site, @user_to_add.web_site
    browser.select :user_time_zone, "value=#{@user_to_add.time_zone}"
    browser.ajax :user_submit
  
    user = User.find_by_email(@user_to_add.email)

    user.should_not be_nil
    user.login.should == @user_to_add.login
    user.first_name.should == @user_to_add.first_name
    user.middle_name.should == @user_to_add.middle_name
    user.last_name.should == @user_to_add.last_name
    user.title.should == @user_to_add.title
    user.email.should == @user_to_add.email
    user.address_1.should == @user_to_add.address_1
    user.address_2.should == @user_to_add.address_2
    user.city.should == @user_to_add.city
    user.state_cd.should == @user_to_add.state_cd
    user.zip.should == @user_to_add.zip
    user.phone.should == @user_to_add.phone
    user.ext.should == @user_to_add.ext
    user.fax.should == @user_to_add.fax
    user.web_site.should == @user_to_add.web_site
    user.time_zone.should == @user_to_add.time_zone
  end

  it "Employee (inactive) user" do
    @user_to_add = Factory.build(:user)

    browser.click :user_active

    browser.type :user_first_name, @user_to_add.first_name
    browser.type :user_middle_name, @user_to_add.middle_name
    browser.type :user_last_name, @user_to_add.last_name
    browser.type :user_title, @user_to_add.title
    browser.type :user_email, @user_to_add.email
    browser.type :user_address_1, @user_to_add.address_1
    browser.type :user_address_2, @user_to_add.address_2
    browser.type :user_city, @user_to_add.city
    browser.type :user_state_cd, @user_to_add.state_cd
    browser.type :user_zip, @user_to_add.zip
    browser.type :user_phone, @user_to_add.phone
    browser.type :user_ext, @user_to_add.ext
    browser.type :user_fax, @user_to_add.fax
    browser.type :user_web_site, @user_to_add.web_site
    browser.select :user_time_zone, "value=#{@user_to_add.time_zone}"
    browser.ajax :user_submit
  
    user = User.find_by_email(@user_to_add.email)
  end
end


shared_examples_for "Employee (inactive) User Input Form" do
end
