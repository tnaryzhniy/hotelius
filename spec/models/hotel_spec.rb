require 'rails_helper'

describe Hotel do

  let(:hotel) { FactoryGirl.create(:hotel) }
  let(:user) { FactoryGirl.create(:user) }

  context 'respond tests' do
    subject {hotel}

    it { should respond_to(:title) }
    it { should respond_to(:stars) }
    it { should respond_to(:breakfast) }
    it { should respond_to(:rooms) }
    it { should respond_to(:foto) }
    it { should respond_to(:price) }
    it { should respond_to(:user_id) }
    it { should be_valid }
  end

  context 'validation tests' do
    subject {hotel}

    context 'title tests' do
      it 'title is not present' do
        hotel.title = ''
        should_not be_valid
      end

      it 'title is too short' do
        hotel.title = 'zz'
        should_not be_valid
      end

      it 'title is too long' do
        hotel.title = 'z'*81
        should_not be_valid
      end

      it 'title is not uniq' do
        hotel_with_same_title = hotel.dup
        hotel_with_same_title.save
        hotel_with_same_title.should_not be_valid
        hotel_with_same_title.title = hotel.title.upcase
        hotel_with_same_title.should_not be_valid
      end
    end

    context 'stars tests' do
      it 'stars is not present' do
        hotel.stars = ''
        should_not be_valid
      end
    end

    context 'price tests' do
      it 'price is not present' do
        hotel.price = ''
        should be_valid
      end

      it 'price is less then 0' do
        hotel.price = -10
        should_not be_valid
      end

      it 'price is more then 999999' do
        hotel.price = 1000000
        should_not be_valid
      end
    end
  end

  context 'method tests' do
    it '#update_raiting should update aver_raiting' do
      FactoryGirl.create_list(:raiting, 4, hotel: hotel, raiting: 2)
      hotel.send(:update_raiting)
      expect(hotel.reload.aver_raiting).to eq(2)

      FactoryGirl.create(:raiting, hotel: hotel, raiting: 4)
      hotel.send(:update_raiting)
      expect(hotel.reload.aver_raiting).to eq(2.4)
    end

    context '#top_five should generate list of top rated hotels' do
      FactoryGirl.create(:hotel, title: 'hotel_top_4', stars: 1, aver_raiting: 4)
      FactoryGirl.create(:hotel, title: 'hotel_not_in_top_1', stars: 1, aver_raiting: 2)
      FactoryGirl.create(:hotel, title: 'hotel_top_3', stars: 1, aver_raiting: 6)
      FactoryGirl.create(:hotel, title: 'hotel_top_1', stars: 1, aver_raiting: 10)
      FactoryGirl.create(:hotel, title: 'hotel_top_5', stars: 1, aver_raiting: 3)
      FactoryGirl.create(:hotel, title: 'hotel_top_2', stars: 1, aver_raiting: 7)
      FactoryGirl.create(:hotel, title: 'hotel_not_in_top_2', stars: 1, aver_raiting: 1)
      top5 = Hotel.order(aver_raiting: :desc).first(5)

        it 'should be list of 5 elements' do
          expect(top5.count).to eq(5)
        end

        it 'first element of list must have name "hotel_top_1"' do
          expect(top5.first.title).to eq('hotel_top_1')
        end

        it 'last element of list must have name "hotel_top_5"' do
          expect(top5.last.title).to eq('hotel_top_5')
        end
    end
  end

end
