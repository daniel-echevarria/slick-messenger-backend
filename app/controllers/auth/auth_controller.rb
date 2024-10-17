require 'net/http'

module Auth
  class AuthController < ApplicationController

    def google
      token = params[:token]
      response = Net::HTTP.get_response(URI("https://oauth2.googleapis.com/tokeninfo?id_token=#{token}"))

      p "this is the response from google #{response}"

      if response.is_a?(Net::HTTPSuccess)
        user_info = JSON.parse(response.body)
        user = User.find_or_create_by(email: user_info['email']) do |u|
          u.password = Devise.friendly_token[0, 20]
          u.name = user_info['name']
          u.avatar_url = user_info['picture']
        end

        profile = Profile.find_or_create_by(user_id: user.id) do |p|
          p.display_name = user_info['name']
          p.name = user_info['name']
          p.picture = user_info['picture']
          p.email = user_info['email']
        end

        p "this is the user #{user.email}"

        if user.persisted?
          jwt = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
          render json: { jwt: jwt }, status: :ok
        else
          render json: { error: 'Could not find the user with this email' }, status: 404
        end
      else
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end
  end
end
