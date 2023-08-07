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
    if spot_params[:image].present?
       result = Vision.image_analysis(spot_params[:image])
      if result
        if @spot.save
          redirect_to spot_path(@spot), notice: "ありがとうございます。情報のシェアに成功しました。"
        else
          flash.now[:alert] = "情報のシェアに失敗しました。"
          render :new
        end
      else
        flash.now[:alert] = "画像が不適切です。"
        render :new
      end
    else
       if @spot.save
          redirect_to spot_path(@spot), notice: "ありがとうございます。情報のシェアに成功しました。"
       else
          flash.now[:alert] = "必須項目を入力してください。"
          render :new
       end
    end
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    if spot_params[:image].present?
      result = Vision.image_analysis(spot_params[:image])
      if result
        if @spot.update(spot_params)
          redirect_to spot_path(@spot), notice: "シェア内容の更新に成功しました。"
        else
          flash.now[:alert] = "シェア内容の更新に失敗しました。"
          render :edit
        end
      else
        flash.now[:alert] = "画像が不適切です。"
        render :edit
      end
    else
      if @spot.update(spot_params)
         redirect_to spot_path(@spot), notice: "シェア内容の更新に成功しました。"
      else
          flash.now[:alert] = "必須項目を入力してください。"
         render :edit
      end
    end
  end


  private

  def spot_params
    params.require(:spot).permit(:image, :tag_id, :member_id, :title, :description, :address, :latitude, :longitude)
  end
end
