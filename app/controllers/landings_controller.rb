class LandingsController < ApplicationController
  def index
    @hotels = Hotel.top_five
  end
end
