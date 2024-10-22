class Profile < ApplicationRecord
  belongs_to :user

  validates :phone, numericality: { only_integer: true }
end
