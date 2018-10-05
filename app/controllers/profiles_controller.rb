class ProfilesController < ApplicationController
  def index
    render json: Profile.all
  end

  def create
    render json: Profile.create(profile_params)
  end

  def show
    id = params[:id]
    render json: Profile.find_by_user_id(id)
  end

  def update
    id = params[:id]
    render json: Profile.update(id, profile_params)
  end

  def destroy
    id = params[:id]
    Profile.find(id).destroy
  end

  private

    def profile_params
      params.require(:profile).permit(:username, :food_types, :bio, :user_id)
    end
end
