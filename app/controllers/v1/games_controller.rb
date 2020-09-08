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
      @square.update(value: params[:value])
      head :no_content
    end


    private 

    def set_game
      @game = current_user.games.find(params[:id])
    end

    def set_square
      @square = @game.squares.find(params[:square_id])
    end

    def square_params
      params.permit(:value)
    end
  end
end
