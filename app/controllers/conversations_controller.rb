class ConversationsController < ApplicationController
  def create
    friendship = Friendship.find(params[:friendship_id])
    conversation = friendship.conversation || friendship.create_conversation
    if conversation.persisted?
      render json: { conversation: conversation, messages: conversation.messages }, status: :ok
    else
      render json: { message: 'Problem when creating the conversation' }, status: :unprocessable_entity
    end
  end
end
