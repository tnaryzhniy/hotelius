require 'rails_helper'

describe Address do
  let(:address) { FactoryGirl.create(:address) }

  context 'respond tests' do
    subject {address}

    it { should respond_to(:country) }
    it { should respond_to(:state) }
    it { should respond_to(:city) }
    it { should respond_to(:street) }
    it { should respond_to(:hotel_id) }
    it { should be_valid }
  end

  context 'validation tests' do
    subject {address}
    it 'country is too long' do
      address.country = 'z' * 51
      should_not be_valid
    end

    it 'state is too long' do
      address.state = 'z' * 51
      should_not be_valid
    end

    it 'city is too long' do
      address.city = 'z' * 51
      should_not be_valid
    end

    it 'street is too long' do
      address.street = 'z' * 51
      should_not be_valid
    end
  end
end