require 'rails_helper'

RSpec.describe Raiting, type: :model do
  it "raiting is valid " do
    FactoryGirl.create(:raiting).should be_valid
  end
end
