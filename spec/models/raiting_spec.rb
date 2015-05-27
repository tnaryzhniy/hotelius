require 'rails_helper'

describe Raiting do
  let(:raiting) { FactoryGirl.create(:raiting) }

  describe 'respond tests' do
    subject {raiting}

    it { should respond_to(:raiting) }
    it { should respond_to(:comment) }
    it { should respond_to(:commenter) }
    it { should respond_to(:user_id) }
    it { should respond_to(:hotel_id) }
    it { should be_valid }
  end

  describe 'validation tests' do

    describe 'raiting tests' do
      it 'raiting is not present' do
        raiting.raiting = ''
        should_not be_valid
      end
    end

    describe 'comment tests' do
      it 'comment is not present' do
        raiting.comment = ''
        should_not be_valid
      end

      it 'comment is too long' do
        raiting.comment = 'z' * 501
        should_not be_valid
      end
    end

    it 'commenter is not present' do
      raiting.commenter = ''
      should_not be_valid
    end

    it 'user_id is not present' do
      raiting.user_id = ''
      should_not be_valid
    end

    it 'hotel_id is not present' do
      raiting.hotel_id = ''
      should_not be_valid
    end
  end
end
