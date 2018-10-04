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

  def update
    id = params[:id]
    render json: Tip.update!(id, tip_params)
  end

  def destroy
    id = params[:id]
    Tip.find(id).destroy
  end

  private

    def tip_params
      params.require(:tip).permit(:restaurant, :food_types, :description, :date, :user_id)
    end
end
