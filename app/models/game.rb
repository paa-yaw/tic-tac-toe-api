class Game < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :winner, class_name: 'User', optional: true

  has_many :squares, dependent: :destroy

  validates :name, :status, :duration, presence: true

  after_create :create_9_squares, :create_ai_player

  def is_over?
    status == 'Game Over'
  end

  
  private 

  def create_9_squares
    9.times do |position_no|
      squares << Square.create(position: position_no + 1, game_id: self.id)
    end
  end

  def create_ai_player
    random_id = rand(1000..10000)
    ai = User.create(username: "AI #{random_id})", email: "ai#{random_id}@gmail.com", password: 'password', password_confirmation: 'password' )
    self.users << ai
  end
end
