class ProfilesController < ApplicationController
  def index
    profiles = Profile.all
    render json: profiles, status: :ok
  end

  def update
    profile = Profile.find(params[:id])
    profile.update(profile_params)

    if profile.save
      render json: { profile: profile, message: 'Profile updated :)' }, status: :ok
    else
      render json: { message: 'Problemo when updating the profile' }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :display_name, :picture, :title)
  end
end
