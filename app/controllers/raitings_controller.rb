class RaitingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @hotel = Hotel.find(params[:hotel_id])
    @raiting = @hotel.raitings.create(raiting_params)
    if @raiting.new_record?
      render('hotels/show')
    else
      @hotel.update_raiting
      redirect_to(hotel_path(@hotel))
    end
  end

  private

  def raiting_params
    params.require(:raiting).permit(:comment, :raiting, :user_id, :commenter)
  end
end
