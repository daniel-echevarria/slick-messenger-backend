require 'net/http'

module Auth
  class AuthController < ApplicationController

    def google
      token = params[:token]
      response = Net::HTTP.get_response(URI("https://oauth2.googleapis.com/tokeninfo?id_token=#{token}"))


      if response.is_a?(Net::HTTPSuccess)
        user_info = JSON.parse(response.body)
        p "this is the user info #{user_info}"
        user_just_created = false
        user = User.find_or_create_by(email: user_info['email']) do |u|
          u.password = Devise.friendly_token[0, 20]
          u.name = user_info['name']
          u.avatar_url = user_info['picture']
          user_just_created = true
        end

        profile = Profile.find_by(user_id: user.id)
        user_just_created && profile.update(
          display_name: user_info['name'],
          name: user_info['name'],
          picture: user_info['picture'],
          email: user_info['email']
        )

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
  end
end
