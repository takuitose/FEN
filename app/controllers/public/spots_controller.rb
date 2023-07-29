class Public::SpotsController < ApplicationController
  before_action :authenticate_member!

  def new
    @spot = Spot.new
  end

  def show
    @spot = Spot.find(params[:id])
    @comment = Comment.new
  end

  def index
    @spots =Spot.page(params[:page])
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.member_id = current_member.id
    @spot.save! ? (redirect_to spot_path(@spot)) : (redirect_to spots_path)
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
