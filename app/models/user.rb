class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_one :profile, dependent: :destroy
  has_many :friendships
  after_create :add_profile

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  private

  def add_profile
    return if profile

    profile = self.profile.create(email: email)
  end
end
