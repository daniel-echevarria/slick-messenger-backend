class MessagesController < ApplicationController
  def create
    conversation = Conversation.find(params[:conversation_id])
    message = conversation.messages.create(user_id: current_user.id, content: params[:message])
    if message.persisted?
      render json: message
    else
      render json: { message: "Couldn't find an active session." }, status: :unprocessable_entity
    end
  end
end
