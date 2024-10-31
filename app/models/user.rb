class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  attr_accessor :created_with_google

  has_one :profile, dependent: :destroy
  has_many :friendships
  after_create :add_profile, unless: -> { created_with_google }

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self


  def add_profile(user_info = {})
    create_profile(email: email) do |p|
      p.display_name = user_info['name'] || email
      p.name = user_info['name'] || email
      p.email = user_info['email'] || email
    end

    attach_google_avatar(user_info) if created_with_google
  end

  def attach_google_avatar(user_info)
    return if profile.avatar.attached?

    profile.avatar.attach(
      io: URI.open(user_info['picture']),
      filename: 'avatar.jpg', # Use a suitable filename
      content_type: 'image/jpeg' # Set the correct MIME type
    )

    profile.save
  end
end
