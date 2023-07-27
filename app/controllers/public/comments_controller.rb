class Public::CommentsController < ApplicationController
  def create
    spot = Spot.find(params[:spot_id])
    comment = current_member.comments.new(comment_params)
    comment.spot_id = spot.id
    comment.save
    redirect_to spot_path(spot)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
