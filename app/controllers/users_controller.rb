class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    users = User.includes(:profile).all
    render json: users, status: :ok
  end

  def current
    profile = current_user.profile
    if current_user
      render json: {
        message: "You are loged in as #{current_user.name || current_user.email}",
        current_user: current_user,
        profile: { **profile.as_json, avatar: url_for(profile.avatar) }
      }, status: :ok
    else
      render json: { message: 'No current user found' }, status: :not_found
    end
  end
end
