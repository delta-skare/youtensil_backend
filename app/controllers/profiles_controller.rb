class ProfilesController < ApplicationController
  def index
    render json: Profile.all
  end

  def create
    render json: Profile.create(profile_params)
  end

  # used to automatically create a profile after registration
  # as well as view profiles
  def show
    id = params[:id]
    profile = Profile.find_or_create_by(user_id: id) do |profile|
      profile.bio = 'Information about you!'
      profile.food_types = 'Good food, great food, delicious food'
    end
    render json: profile
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
