class Square < ApplicationRecord
  belongs_to :game

  validates :position, :game_id, presence: true
end
