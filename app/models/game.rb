class Game < ApplicationRecord
  belongs_to :user

  validates :name, :status, :duration, presence: true
end
