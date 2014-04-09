require 'spec_helper'

describe Task do

  it "has a valid factory" do
    FactoryGirl.build(:task).should be_valid
  end

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:description) }
end
