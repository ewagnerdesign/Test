require 'spec_helper'

describe Role do
  #name
  it { should have_db_column(:name).of_type(:string).with_options(:limit => 45, :null => false )}
  it { should have_db_index(:name).unique(true) }
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}
  it { should ensure_length_of(:name).is_at_most(45)}

  #description
  it { should have_db_column(:description).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:description)}
  it { should ensure_length_of(:description).is_at_most(255)}

  #permissions
  it {should have_many(:permission_roles) }
  it {should have_many(:permissions) }

  #users
  it {should have_many(:role_users) }
  it {should have_many(:users) }

  #site_users
  it {should have_many(:role_site_users) }
  it {should have_many(:site_users) }

  #study_users
  it {should have_many(:role_study_users) }
  it {should have_many(:study_users) }

  #study_users
  it {should have_many(:role_study_site_users) }
  it {should have_many(:study_site_users) }

  describe ".create" do
    subject { Factory.create(:role) }

    it { should be_valid }
    its(:errors) { should be_empty }
  end

  describe ".removable" do
    subject { Factory.create(:role) }
    it { should be_removable }

    it "should not be removable if user attached" do
      subject.users += [Factory.create(:user)]
      subject.should_not be_removable
    end

    it "should not be removable if site_user attached" do
      subject.site_users += [Factory.create(:site_user)]
      subject.should_not be_removable
    end

    it "should not be removable if study_user attached" do
      subject.study_users += [Factory.create(:study_user)]
      subject.should_not be_removable
    end

    it "should not be removable if study_site_user attached" do
      study = Factory(:study)
      site = Factory(:site)
      user = Factory(:user)
      site.contacts += [user]
      study_site_user = StudySiteUser.create(:site_user => site.site_users.first, :study => study)

      subject.study_site_users += [study_site_user]
      subject.should_not be_removable
    end
  end

  describe "categories scopes" do
    before(:each) do
      @r_system = Factory.create(:role, :category => Role::SYSTEM_LEVEL)
      @r_study = Factory.create(:role, :category => Role::STUDY_LEVEL)
      @r_site = Factory.create(:role, :category => Role::SITE_LEVEL)
    end

    %w(system study site).each do |l|
      it "should find #{l} level role" do
        Role.send("#{l}_level").should == [instance_variable_get("@r_#{l}")]
      end
    end
  end
end
