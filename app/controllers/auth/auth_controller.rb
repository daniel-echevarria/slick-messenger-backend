require 'net/http'
require 'open-uri'

module Auth
  class AuthController < ApplicationController
    def fetch_user_info(token)
      response = Net::HTTP.get_response(URI("https://oauth2.googleapis.com/tokeninfo?id_token=#{token}"))
      JSON.parse(response.body)
    end

    def google
      user_info = fetch_user_info(params[:token])

      if user_info
        user = find_or_create_user(user_info)
        user.add_profile(user_info) unless user.profile

        if user.persisted?
          jwt = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
          render json: { jwt: jwt }, status: :ok
        else
          render json: { error: 'Could not find the user with this email' }, status: :not_found
        end
      else
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end

    def find_or_create_user(user_info)
      User.find_or_create_by(email: user_info['email']) do |u|
        u.password = Devise.friendly_token[0, 20]
        u.name = user_info['name']
        u.created_with_google = true
      end
    end
  end
end
