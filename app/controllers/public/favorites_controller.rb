class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    @spot = Spot.find(params[:spot_id])
    favorite = @spot.favorites.new(member_id: current_member.id)
    favorite.save
  end

  def destroy
    @spot = Spot.find(params[:spot_id])
    favorite = current_member.favorites.find_by(spot_id: @spot.id)
    favorite.destroy
  end

end
