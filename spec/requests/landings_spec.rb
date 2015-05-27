require 'rails_helper'

describe 'Landings', type: :request do
  describe 'GET /landings' do
    it "should have the content 'Room description'" do
      visit '/landings/index'
      expect(page).to have_content('Room description')
    end
  end
end
