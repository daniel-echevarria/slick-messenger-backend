class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :validatable,
        #  :omniauthable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self
        #  omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    user || user = User.create(
      email: data['email'],
      password: Devise.friendly_token[0,20]
    )
    user
  end
end

