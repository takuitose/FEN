class Admin::SearchesController < ApplicationController
  before_action :authenticate_member!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "Member"
      @members = Member.looks(params[:search], params[:word])
    else
      @spots = Spot.looks(params[:search], params[:word])
    end
  end
end
