require 'spec_helper'

describe Project do

  it "has a valid factory" do
    FactoryGirl.build(:project).should be_valid
  end

  it { should belong_to(:owner).class_name(User) }

  it { should ensure_length_of(:name).is_at_least(4).is_at_most(30) }

  it { should_not allow_value('').for(:name) }

  it { should validate_presence_of(:owner) }
end
