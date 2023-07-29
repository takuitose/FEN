class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit, :update]

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @spots = @member.spots.order(id: :desc).limit(3)
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update(member_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :email)
  end

  def ensure_guest_member
    @member = Member.find_by(id: params[:id])
    if @member && @member.email == 'guest@fukuoka.com'
      redirect_to mypage_path, alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
