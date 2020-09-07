class User < ApplicationRecord
  has_secure_password

  has_many :games
  has_many :squares

  validates :email, :username, :password_digest, presence: true 
  validates :email, uniqueness: true
end
