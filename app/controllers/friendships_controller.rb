class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:contact_id])
    friendship =
      Friendship.find_by(first_user_id: friend.id, second_user_id: current_user.id) ||
      Friendship.find_or_create_by(first_user_id: current_user.id, second_user_id: friend.id)
    render json: friendship
  end
end
