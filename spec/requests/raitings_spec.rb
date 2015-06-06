require 'rails_helper'

describe 'Raitings' do
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


  context 'Create comment' do

    it 'should successfully' do
      login(user)
      create_hotels(1)
      visit '/hotels'
      click_link 'Hotel details'
      page.should have_button 'Create Raiting'
      fill_in 'Comment', with: 'Test comment'
      choose '2'
      click_button 'Create Raiting'
      page.should have_content 'Test comment'
    end

    it 'should fail' do
      login(user)
      create_hotels(1)
      visit '/hotels'
      click_link 'Hotel details'
      page.should have_button 'Create Raiting'
      fill_in 'Comment', with: 'Test comment'
      # choose '2'
      click_button 'Create Raiting'
      page.should have_content '1 error prohibited raiting for this hotel from being saved'
    end
  end

  context 'Displaying comments' do

    it 'in hotel details' do
      login(user)
      create_raitings(1)
      visit '/hotels'
      click_link 'Hotel details'
      page.should have_content 'Comments'
      expect(first('strong')).to have_content('Commenter')
    end
  end
end
