class RaitingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @hotel = Hotel.find(params[:hotel_id])
    @raiting = @hotel.raitings.create(raiting_params)
    @hotel.update_raiting
    @raiting.save ? redirect_to(hotel_path(@hotel)) : render('hotels/show')
  end

  private

  def raiting_params
    params.require(:raiting).permit(:comment, :raiting, :user_id, :commenter)
  end
end
