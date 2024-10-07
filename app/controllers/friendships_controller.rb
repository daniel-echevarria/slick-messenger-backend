class FriendshipsController < ApplicationController
  def index
  end

  def create
    friend = User.find(params[:contact_id])
    puts "this is my friend #{friend}"
    puts "this is the current user #{current_user}"
    friendship =
      Friendship.find_by(first_user_id: friend.id, second_user_id: current_user.id) ||
      Friendship.find_or_create_by(first_user_id: current_user.id, second_user_id: friend.id)
    render json: friendship
  end

  def destroy
  end
end
