require 'spec_helper'

# http://www.pivotaltracker.com/projects/51890?story_id=3012515
shared_examples_for "editable visit" do
  context "editable: " do
    it "should be editable" do
      visit.should be_editable
    end

    it "shouldn't be possible to edit" do
      visit.form_instances += [Factory.build(:form_instance), Factory.build(:form_instance)]
      visit.should_not be_valid
    end

    it "shouldn't be possible to edit if descendants are visited" do
      Factory.create(:form_instance, :visit => Factory.create(:visit_relative, :prev_visit => Factory.create(:visit_relative, :prev_visit => visit)))
      visit.reload
      visit.should have(1).next_visits
      visit.should_not be_editable
      visit.should_not be_valid
    end
  end
end

describe Visit do
  context "base db features" do
    #number
    it { should have_db_column(:number).of_type(:string).with_options(:limit => 45, :null => false )}
    it { should validate_presence_of(:number)}
    it { should ensure_length_of(:number).is_at_most(45)}

    #name
    it { should have_db_column(:name).of_type(:string).with_options(:limit => 255, :null => false )}
    it { should validate_presence_of(:name)}
    it { should ensure_length_of(:name).is_at_most(255)}

    #start_date
    it { should have_db_column(:start_date).of_type(:date).with_options(:null => true )}

    #end_date
    it { should have_db_column(:end_date).of_type(:date).with_options(:null => true )}

    #prev_visit_start_offset_day
    it { should have_db_column(:prev_visit_start_offset_day).of_type(:integer).with_options(:null => true )}

    #prev_visit_end_offset_day
    it { should have_db_column(:prev_visit_end_offset_day).of_type(:integer).with_options(:null => true )}

    #prev_visit_id
    it { should have_db_column(:prev_visit_id).of_type(:integer).with_options(:null => true )}

    #notes
    it { should have_db_column(:notes).of_type(:text).with_options(:null => true )}

    #status
    it { should have_db_column(:status).of_type(:string).with_options(:limit => 45, :null => true )}
    it { should_not validate_presence_of(:status)}
    it { should ensure_length_of(:status).is_at_most(45)}

    it { should have_many(:study_arm_visits) }
    it { should have_many(:study_arms) }
  end

  context "date named scopes" do
    before(:each) do
      @v1 = Factory.create(:visit, :start_date => Date.today)
      @v2 = Factory.create(:visit, :start_date => Date.today-2)
      @v3 = Factory.create(:visit_relative, :prev_visit => @v1)
    end

    it "should find all visits" do
      Visit.all.should == [@v1,@v2,@v3]
    end

    it "should find today visits" do
      Visit.today.should == [@v1]
    end

    it "should find overdue visits" do
      Visit.overdue.should == [@v2]
    end

    it "should find today and overdue visits" do
      Visit.today_overdue.should == [@v1,@v2]
    end

    it "should visit by date" do
      Visit.by_date(Date.today-2).should == [@v2]
    end
  end

  context "Absolute" do
    let(:visit) { Factory.build(:visit_absolute) }
    subject { visit }

    it { should validate_presence_of(:start_date) }
    it { should_not validate_presence_of(:end_date) }
    it { should_not validate_presence_of(:prev_visit_start_offset_day) }
    it { should_not validate_presence_of(:prev_visit_end_offset_day) }
    it { should_not validate_presence_of(:prev_visit_id) }

    it "should create a new instance with start_date only" do
      visit.should be_valid
    end

    it "should create a new instance with start_date and end_date" do
      visit.end_date = visit.start_date + 1
      visit.should be_valid
    end

    it "shouldn't create a new instance with start_date >= end_date" do
      visit.end_date = visit.start_date - 1
      visit.should_not be_valid
    end

    it_should_behave_like "editable visit"
  end

  context "Relative" do
    let(:visit) { Factory.build(:visit_relative) }
    subject { visit }

    it { should_not validate_presence_of(:start_date) }
    it { should_not validate_presence_of(:end_date) }
    it { should validate_presence_of(:prev_visit_start_offset_day) }
    it { should validate_numericality_of(:prev_visit_start_offset_day) }
    it { should validate_presence_of(:prev_visit_end_offset_day) }
    it { should validate_numericality_of(:prev_visit_end_offset_day) }

    it "should create a new instance given valid attributes" do
      visit.should be_valid
    end

    context "(dates)" do
      it "shouldn't create a new instance without prev_visit_start_offset_day" do
        visit.prev_visit_start_offset_day = nil
        visit.should_not be_valid
      end

      it "shouldn't create a new instance with negative prev_visit_start_offset_day" do
        visit.prev_visit_start_offset_day = -1
        visit.should_not be_valid
      end

      it "shouldn't create a new instance without prev_visit_end_offset_day" do
        visit.prev_visit_end_offset_day = nil
        visit.should_not be_valid
      end
    end

    context "(references)" do
      it "should allow chain of visits" do
        visit2 = Factory.build(:visit_relative, :prev_visit => visit)
        visit2.should be_valid

        visit3 = Factory.build(:visit_relative, :prev_visit => visit2)
        visit3.should be_valid
      end

      it "checks descendant_visits" do
        visit2 = Factory.create(:visit_relative, :prev_visit => visit)
        visit3 = Factory.create(:visit_relative, :prev_visit => visit2)
        visit.reload
        visit.descendant_visits.should eql [visit2, visit3]
      end

      it "should not be possible: direct self-references" do
        visit.prev_visit = visit
        visit.should_not be_valid
      end

      it "should not be possible: indirect self-references" do
        visit2 = Factory.build(:visit_relative, :prev_visit => visit)
        visit3 = Factory.build(:visit_relative, :prev_visit => visit2)

        visit.prev_visit = visit3
        visit.should_not be_valid
      end
    end

    it_should_behave_like "editable visit"
  end
end
