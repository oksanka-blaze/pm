require 'spec_helper'

describe User do

  it "has a valid factory" do
    FactoryGirl.build(:user).should be_valid
  end

  it { should have_many(:projects).with_foreign_key('owner_id') }

end
