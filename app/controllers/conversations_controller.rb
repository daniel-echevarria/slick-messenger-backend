class ConversationsController < ApplicationController
  def create
    friendship = Friendship.find(params[:friendship_id])
    conversation = friendship.conversation || friendship.create_conversation
    render json: conversation
  end
end
