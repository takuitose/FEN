class Public::SpotsController < ApplicationController
  before_action :authenticate_member!

  def show
    @spot = Spot.find(params[:id])
  end

  def index
    @spot = Spot.new
    @spots = Spot.all
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.member_id = current_member.id
    @spot.save! ? (redirect_to spot_path(@spot), notice: "You have created book successfully.") : (redirect_to spots_path)
  end

  def edit

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
