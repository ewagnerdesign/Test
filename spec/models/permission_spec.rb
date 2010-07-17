require 'spec_helper'

describe Permission do
  #name  
  it { should have_db_column(:name).of_type(:string).with_options(:limit => 100, :null => false )}
  it { should have_db_index(:name).unique(true) }
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}
  it { should ensure_length_of(:name).is_at_most(100)}

  #description  
  it { should have_db_column(:description).of_type(:string).with_options(:limit => 255, :null => false )}
  it { should validate_presence_of(:description)}
  it { should ensure_length_of(:description).is_at_most(255)}

  it {should have_many(:permission_roles) }
  it {should have_many(:roles) }
  
  describe ".create" do
    subject { Factory.create(:permission) }

    it { should be_valid }
    its(:errors) { should be_empty }
  end
    
  describe ".removable" do
    subject { Factory.create(:permission) }
    it { should be_removable }

    it "should not be removable if role attached" do
      subject.roles += [Factory.create(:role)]
      subject.should_not be_removable
    end
  end
end
