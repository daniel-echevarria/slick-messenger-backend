class Profile < ApplicationRecord
  has_one_attached :avatar, dependent: :destroy
  belongs_to :user
end
