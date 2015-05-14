require 'rails_helper'

describe Hotel do

  let(:hotel) { FactoryGirl.create(:hotel) }
  let(:user) { FactoryGirl.create(:user) }
  #let(:raiting) { FactoryGirl.create(:raiting) }

  it '#update_raiting should update aver_raiting' do
    FactoryGirl.create_list(:raiting, 4, hotel: hotel, raiting: 2)
    hotel.send(:update_raiting)
    expect(hotel.reload.aver_raiting).to eq(2)

    FactoryGirl.create(:raiting, hotel: hotel, raiting: 4)
    hotel.send(:update_raiting)
    expect(hotel.reload.aver_raiting).to eq(2.4)
  end

  it '#create_raiting should save full raiting' do
    hotel
    current_user = user
    parametrs = {comment: 'New test comment', raiting: 3}
    expect(Raiting.count).to eq(0)
    hotel.create_raiting(parametrs, current_user)
    expect(Raiting.count).to eq(1)
    expect(Raiting.first.comment).to eq('New test comment')
  end

end
