require 'rails_helper'

describe 'Hotels' do
  let(:user) {User.create!(email:'tariq@tariq.tariq', password:'0987654321')}
  let(:hotel) {FactoryGirl.create(:hotel)}

  def login(user)
    visit '/users/sign_in'
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def create_hotels(count)
    count.times do
      FactoryGirl.create(:hotel)
    end
  end

  def create_raitings(count)
    count.times do
      FactoryGirl.create(:raiting, hotel_id: hotel.id, user_id: hotel.user_id )
    end
  end

  context 'Displaying hotels' do

    it 'displays five top rated hotels in landing' do
      login(user)
      create_hotels(10)
      visit '/'
      page.should have_content('User raiting', count: 5)
    end

    it 'displays all hotels in Hotels page' do
      login(user)
      create_hotels(15)
      visit '/hotels'
      page.should have_content('Hotel details', count: 15)
    end

    it 'displays hotel details' do
      login(user)
      create_hotels(1)
      visit '/hotels'
      click_link 'Hotel details'
      page.should have_content 'User raiting'
      page.should have_content 'Price for room'
      page.should have_content 'Breakfast'
      page.should have_content 'Comments'
    end
  end

  context 'Create hotel' do

    it 'should successfully' do
      login(user)
      visit '/hotels'
      click_link 'Add new hotel'
      page.should have_button 'Create Hotel'
      fill_in 'Hotel name', with: 'Test hotel'
      choose '2'
      fill_in 'Hotel description', with: 'Test Hotel description'
      fill_in 'Country', with: 'Test Country'
      fill_in 'State', with: 'Test State'
      fill_in 'City', with: 'Test City'
      fill_in 'Street', with: 'Test Street'
      click_button 'Create Hotel'
      page.should have_content 'Test hotel'
    end

    it 'should fail' do
      login(user)
      visit '/hotels'
      click_link 'Add new hotel'
      page.should have_button 'Create Hotel'
      fill_in 'Hotel name', with: 'Test hotel'
      # choose '2'
      fill_in 'Hotel description', with: 'Test Hotel description'
      fill_in 'Country', with: 'Test Country'
      fill_in 'State', with: 'Test State'
      fill_in 'City', with: 'Test City'
      fill_in 'Street', with: 'Test Street'
      click_button 'Create Hotel'
      page.should have_content '1 error prohibited this hotel from being saved'
    end
  end
end
