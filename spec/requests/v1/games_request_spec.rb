require 'rails_helper'

RSpec.describe "Games", type: :request do
  let!(:user) { create(:user) }
  let!(:headers) { valid_headers }

  describe "POST#start" do
    context 'when no game is in-progress' do
      before { post '/games/start', params: {}, headers: headers }

      it 'returns status code of 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns 9 squares' do
        expect(json['data'].size).to eq(9)
      end
    end

    context 'when there is a game in-progress' do
      let!(:game) { create(:game) }
      let!(:square) { create_list(:square, 9, game_id: game.id, user_id: user.id) }

      before do 
        game.users << user
        post '/games/start', params: {}, headers: headers
      end

      it 'returns status code of 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns message object' do
        expect(json['message']).to eq('You have a game already in progress')
      end
    end
  end

  describe 'PATCH#register_move' do
    let!(:game) { create(:game) }
    let!(:squares) { create_list(:square, 9, game_id: game.id, user_id: user.id) }
    let!(:valid_params) { { value: 'O' }.to_json }
    
    context 'user registers move' do
      before do 
        game.users << user
        patch "/games/#{game.id}/squares/#{squares.first.id}/register_move", params: valid_params, headers: headers
      end

      it 'updates square' do
        expect(response).to have_http_status(204)
      end

      it 'square updated' do
        square = squares.first
        expect(square.reload.value).to eq('O') 
      end
    end
  end
end
