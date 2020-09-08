Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
   post 'games/start', to: 'games#start', as: :start_game
   patch 'games/:id/squares/:square_id/register_move', to: 'games#register_move', as: :register_move
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
