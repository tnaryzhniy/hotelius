require 'rails_helper'

RSpec.describe User, type: :model do
  it "user is valid " do
    FactoryGirl.create(:user).should be_valid
  end
end
