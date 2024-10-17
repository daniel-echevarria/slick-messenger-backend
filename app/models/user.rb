class User < ApplicationRecord
  has_one :profile

  after_create :add_profile

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  private

  def add_profile
    unless self.profile
      self.create_profile do |p|
        p.email = self.email
        p.picture = 'generic profile image url'
      end
    end
  end
end
