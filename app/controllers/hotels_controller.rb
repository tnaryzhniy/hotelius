class HotelsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @hotels = Hotel.all
  end

  def show
    @hotel = Hotel.find(params[:id])
    @raiting = @hotel.raitings.build
  end

  def new
    @hotel = Hotel.new
    @hotel.build_address
  end

  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user = current_user
    @hotel.save ? redirect_to(@hotel) : render('hotels/new')
  end

  def destroy
    Hotel.find(params[:id]).destroy
    redirect_to hotels_path
  end

  private

  def hotel_params
    params.require(:hotel).permit(:title, :stars, :rooms, :price, :breakfast, :foto, :foto_cache,
                                  address_attributes: [:country, :state, :city, :street])
  end
end
