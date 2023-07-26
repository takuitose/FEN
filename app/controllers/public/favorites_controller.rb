class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    @spot = Spot.find(params[:spot_id])
    current_member.likes.create(spot: @spot)
    redirect_to @spot, notice: 'いいねしました。'
  end

  def destroy
    @spot = Spot.find(params[:spot_id])
    current_member.likes.find_by(spot: @spot).destroy
    redirect_to @spot, notice: 'いいねを取り消しました。'
  end

end
