class Public::MembersController < ApplicationController

  def show
    @spots = Spot.order(id: :desc).limit(3)
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

end
