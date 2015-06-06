require 'rails_helper'

describe 'Authorization' do

  let(:user) {User.create!(email: 'tariq@tariq.tariq', password: '0987654321')}

  def login(user)
    visit '/users/sign_in'
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  context 'on landing'do

    it 'sign in' do
      visit '/'
      click_link 'Sign in'
      page.should have_content 'Log in'
    end

    it 'sign up' do
      visit '/'
      click_link 'Sign up'
      page.should have_content 'Registration'
    end

    it 'allows Add new hotel' do
      login(user)
      visit '/'
      page.should have_content 'Add new hotel'
    end

    it 'should not allow Add new hotel' do
      visit '/'
      page.should_not have_content 'Add new hotel'
      page.should have_content 'Sign up now!'
    end
  end

  context 'on hotels list' do

    it 'sign in' do
      visit '/hotels'
      find('h4').click_link('Sign in')
      page.should have_content 'Log in'
    end

    it 'sign up' do
      visit '/hotels'
      click_link 'Sign up'
      page.should have_content 'Registration'
    end

    it 'allows Add new hotel' do
      login(user)
      visit '/hotels'
      page.should have_content 'Add new hotel'
    end

    it 'should not allow Add new hotel' do
      visit '/hotels'
      page.should_not have_content 'Add new hotel'
      page.should have_content 'Sign in to add new hotel'
    end
  end

  context 'on auth pages' do

    it 'redirects to root after sign in' do
      login(user)
      page.should have_content "Hello, #{user.email}"
    end

    it 'redirects to root after sign up' do
      visit '/users/sign_up'
      fill_in 'Email',                  with: 'test_user@test.com'
      fill_in('Password',               with: '123456', match: :prefer_exact)
      fill_in('Password confirmation',  with: '123456', match: :prefer_exact)
      click_button 'Sign up'
      page.should have_content 'Hello, test_user@test.com'
    end
  end

  context 'on hotel details' do

    it 'allows add comment' do
      login(user)
      FactoryGirl.create(:hotel)
      visit '/hotels'
      click_link 'Hotel details'
      page.should have_content 'Comments'
      page.should have_button 'Create Raiting'
    end

    it 'should not allow add comment' do
      FactoryGirl.create(:hotel)
      visit '/hotels'
      click_link 'Hotel details'
      page.should have_content 'Sign in or Sign up'
      page.should_not have_button 'Create Raiting'
    end
  end
end





