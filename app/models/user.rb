class User < ApplicationRecord
  has_one :profile
  has_many :tips
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self
end
