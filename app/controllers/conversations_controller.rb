class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def create
    interlocutor = User.find(params[:interlocutor_id])
    puts "this is my interlocutor #{interlocutor}"
    puts "this is the current user #{current_user}"
    conversation =
      Conversation.find_by(first_user_id: interlocutor.id, second_user_id: current_user.id) ||
      Conversation.find_or_create_by(first_user_id: current_user.id, second_user_id: interlocutor.id)
    render json: conversation
  end

  def show
  end

  def destroy
  end
end
