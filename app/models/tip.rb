class Tip < ApplicationRecord
  belongs_to :user
  validates :user_id, :description, :food_types, :restaurant, presence: true
end
