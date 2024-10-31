class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    puts 'user index gets called'
    users = User.includes(:profile).all
    render json: users, status: :ok
  end

  def current
    profile = current_user.profile
    if current_user
      render json: {
        message: "You are loged in as #{current_user.email}",
        current_user: current_user,
        profile: {
          **profile.as_json,
          avatar: profile.avatar.attached? ? url_for(profile.avatar) : 'https://img.freepik.com/free-vector/hand-drawn-question-mark-silhouette_23-2150940537.jpg?t=st=1729677656~exp=1729681256~hmac=c384dc151aea30d18319b0b8534fc89d8df876a7f6390713a60b5007e595a157&w=1800' }
      }, status: :ok
    else
      render json: { message: 'No current user found' }, status: :not_found
    end
  end
end
