class RaitingsController < ApplicationController
  before_filter :authenticate_user!

  #def new
  #  @hotel = Hotel.find(params[:hotel_id])
  #  @raiting = @hotel.raitings.new
  #end

  def create
    @hotel = Hotel.find(params[:hotel_id])
    @raiting = @hotel.raitings.new(raiting_params)
    @raiting.save
    @hotel.update_raiting

    @raiting.save ? redirect_to(hotel_path(@hotel)) : render("hotels/show")
    #redirect_to hotel_path(@hotel)
  end



  private

  def raiting_params
    params.require(:raiting).permit(:comment, :raiting, :user_id, :commenter)
  end
end
