require 'net/http'
require 'open-uri'

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
        end

        create_profile(user, user_info)

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

    def create_profile(user, user_info)
      profile = Profile.find_or_create_by(user_id: user.id)

      profile.update(
        display_name: user_info['name'],
        name: user_info['name'],
        email: user_info['email']
      )
      unless profile.avatar.attached?
        profile.avatar.attach(
        io: URI.open(user_info['picture']),
        filename: 'avatar.jpg', # Use a suitable filename
        content_type: 'image/jpeg' # Set the correct MIME type
        )
      end

      profile.save
    end
  end
end
