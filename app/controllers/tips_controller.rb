class TipsController < ApplicationController
  def index
    render json: Tip.all
  end

  def create
    render json: Tip.create(tip_params)
  end

  def show
    id = params[:id]
    render json: Tip.find(id)
  end

  def show_user_tips
    render json: Tip.where("user_id = ?", params[:user_id])
  end

  def show_following_tips
    following = params[:following].split(",")
    test = following.map { |e| e.to_i }
    render json: Tip.where("user_id in (?)", test)
  end

  def update
    id = params[:id]
    render json: Tip.update(id, tip_params)
  end

  def destroy
    id = params[:id]
    Tip.find(id).destroy
  end

  private

    def tip_params
      params.require(:tip).permit(:restaurant, :food_types, :description, :user_id, :image)
    end
end
