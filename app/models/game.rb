class Game < ApplicationRecord
  has_and_belongs_to_many :users

  has_many :squares, dependent: :destroy

  validates :name, :status, :duration, presence: true

  after_create :create_9_squares

  
  private 

  def create_9_squares
    9.times do |position_no|
      squares << Square.create(position: position_no + 1, game_id: self.id)
    end
  end
end
