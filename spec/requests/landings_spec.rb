require 'rails_helper'

describe 'Landings', type: :request do
  describe 'GET /landings' do
    it "should have the content 'This is the list of TOP 5 hotels'" do
      visit '/landings/index'
      expect(page).to have_content('This is the list of TOP 5 hotels')
    end
  end
end
