class Profile < ApplicationRecord
  belongs_to :user
  validates :bio, :food_types, :user_id, presence: true
end
