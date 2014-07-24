require 'spec_helper'

describe Task do

  it "has a valid factory" do
    expect(FactoryGirl.build(:task)).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:description) }
end
