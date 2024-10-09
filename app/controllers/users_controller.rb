class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    users = User.all
    render json: users, status: :ok
  end

  def you
    you = current_user
    if you
      render json: { message: "You are loged in as #{you.name || you.email}", current_user: you }, status: :ok
    else
      render json: { message: 'No current user found' }, status: :not_found
    end
  end
end
