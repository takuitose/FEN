class Admin::SpotsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      redirect_to spot_path(@spot)
    else
      render :edit
    end
  end


  private

  def spot_params
    params.require(:spot).permit(:image, :tag_id, :member_id, :title, :description, :address, :latitude, :longitude)
  end
end
