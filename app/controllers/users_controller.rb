class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    users = User.all
    render json: users, status: :ok
  end

  def current
    if current_user
      render json: { message: "You are loged in as #{current_user.name || current_user.email}", current_user: current_user }, status: :ok
    else
      render json: { message: 'No current user found' }, status: :not_found
    end
  end
end
