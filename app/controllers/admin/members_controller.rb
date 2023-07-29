class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_member, only: [:show, :update]

  def index
    @members = Member.page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
    @spots = @member.spots.order(id: :desc).limit(3)
  end

  def edit

  end

  def update
    @member.update(member_params) ? (redirect_to admin_member_path(@member)) : (render :edit)
  end

  private

  def member_params
    params.require(:member).permit(:status)
  end

  def ensure_member
    @member = Member.find(params[:id])
  end
end
