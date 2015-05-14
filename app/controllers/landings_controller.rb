class LandingsController < ApplicationController
  def index
    @top5 = Hotel.top_five
  end
end
