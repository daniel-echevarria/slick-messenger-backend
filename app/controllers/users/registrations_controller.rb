class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix

  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      # send welcome email
      UserMailer.with(user: current_user).welcome_email(current_user).deliver_later

      render json: {
        status: { code: 200, message: 'Signed up successfully.', ok:true },
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }, status: :created
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
