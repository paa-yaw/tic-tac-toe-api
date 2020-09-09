module V1
  class GamesController < ApplicationController
    before_action :set_game, only: [:register_move]
    before_action :set_square, only: [:register_move]

    def start
      games = Game.where(status: 'in-progress')
      if games.any? { |game| game.users.include?(current_user) }
        json_response({ message: 'You have a game already in progress' })
      else
        game_no = Game.all.size + 1
        game = current_user.games.create!(name: "Game #{game_no}", status: 'in-progress')
        json_response(game.squares, :created)
      end
    end

    def register_move
      register_ai_move

      if @game.is_over?
        json_response({ message: 'This Game is Over!' })
      else
        if @square.value
          json_response({ message: 'move already registered' })
        else
          @square.update!(value: 'X', user_id: current_user.id)
          check_for_winner
        end
      end
    end

    
    private 

    def set_game
      @game = current_user.games.find(params[:id])
      @other_player = @game.users.where.not(id: current_user.id).first
    end

    def set_square
      @square = @game.squares.find(params[:square_id])
    end

    def register_ai_move
      set_game
      first_square = @game.squares.where(value: nil).first.id
      last_square = @game.squares.where(value: nil).last.id
      random_square = @game.squares.find(rand(first_square..last_square))

      # to avoid already registered move
      random_square.update!(value: 'O', user_id: @other_player.id)
    end

    # Note should be in Game model
    def check_for_winner
      set_game
      if current_user.has_3_or_more_moves?(@game.id) || @other_player.has_3_or_more_moves?(@game.id)
        if current_user.has_3_moves_in_a_row?(@game.id)
          @game.update(winner_id: current_user.id, duration: (Time.now - @game.created_at).to_i)
          @game.update(status: 'Game Over')
          json_response({ message: "Winner is #{current_user.username}"})
        elsif @other_player.has_3_moves_in_a_row?(@game.id)
          @game.update(winner_id: @other_player.id, duration: (Time.now - @game.created_at).to_i)
          @game.update(status: 'Game Over')
          json_response({ message: "Winner is #{@other_player.username}" })
        else
          head :no_content
        end
      else
        head :no_content
      end
    end
  end
end
