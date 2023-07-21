class Public::SpotsController < ApplicationController
  def new
    @spot = Spot.new
  end

  def show

  end

  def index
    @spot = Spot.new
    @spots = Spot.all
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.save ? (redirect_to spot_path(@spot)) : (redirect_to spots_path)
  end

  def edit

  end

  def update
    @spot.update(spot_params) ? (redirect_to spot_path(@spot)) : (render :edit)
  end

  private

  def spot_params
    params.require(:spot).permit(:image, :tag_id, :title, :description, :address, :latitude, :longtude)
  end
end
