class RaitingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @hotel = Hotel.find(params[:hotel_id])
    @hotel.create_raiting(raiting_params, current_user)
    redirect_to hotel_path(@hotel)
  end



  private

  def raiting_params
    params.require(:raiting).permit(:comment, :raiting)
  end
end
