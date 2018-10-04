class Profile < ApplicationRecord
  belongs_to :user
  validates :username, :bio, :food_types, :user_id, presence: true
end
