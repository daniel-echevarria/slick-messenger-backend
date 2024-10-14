require 'net/http'

module Auth
  class AuthController < ApplicationController

    def google
      token = params[:token]
      response = Net::HTTP.get_response(URI("https://oauth2.googleapis.com/tokeninfo?id_token=#{token}"))

      if response.is_a?(Net::HTTPSuccess)
        user_info = JSON.parse(response.body)
        user = User.find_or_create_by(email: user_info['email']) do |u|
          u.password = Devise.friendly_token[0, 20]
          u.name = user_info['name']
          u.avatar_url = user_info['picture']
        end

        # Generate a JWT token
        jwt = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
        render json: { jwt: jwt }, status: :ok
      else
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end
  end
end
