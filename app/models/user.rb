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
    return if profile

    create_profile do |p|
      p.email = email
      p.picture = 'https://img.freepik.com/free-vector/hand-drawn-question-mark-silhouette_23-2150940537.jpg?t=st=1729677656~exp=1729681256~hmac=c384dc151aea30d18319b0b8534fc89d8df876a7f6390713a60b5007e595a157&w=1800'
    end
  end
end
