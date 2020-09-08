class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :games
  has_many :squares

  validates :email, :username, :password_digest, presence: true 
  validates :email, uniqueness: true


  def moves_per_game(game_id)
    squares.where(game_id: game_id).where.not(value: nil)
  end

  def has_3_or_more_moves?(game_id)
    moves_count = moves_per_game(game_id).size
    moves_count == 3 || (moves_count > 3 && moves_count <= 9)
  end

  def has_3_moves_in_a_row?(game_id) 
    moves = squares.where(game_id: game_id)
    move_positions = moves.map { |move| [move.position] }.flatten
    [[1, 2, 3], [1, 5, 9], [1, 4, 7], [ 2, 5, 8], [3, 6, 9], [3, 5, 7], [7, 8, 9], [4, 5, 6]].each do |winning_positions|
      if move_positions == winning_positions || Set[*winning_positions].subset?(Set[*move_positions])
        return true
        break
      end
    end
  end
end
