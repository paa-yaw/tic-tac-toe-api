require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let!(:user) { create(:user) }
  let!(:header) { { 'Authorization' => token_generator(user.id) } }
  let!(:invalid_request_obj) { described_class.new({}) }
  let!(:valid_request_obj) { described_class.new(header) }

  context 'when request is valid' do
    it 'returns valid user' do
      expect(valid_request_obj.call[:user]).to eq(user)
    end 
  end

  context 'when request is invalid' do
    context 'missing token' do
      it 'raises MissingToken error' do
        expect{ invalid_request_obj.call }.to raise_error(
            ExceptionHandler::MissingToken, 'Missing token'
        )
      end
    end

    context 'invalid token' do
      let!(:invalid_header) { { 'Authorization' => token_generator(5) } }
      let!(:invalid_request_obj) { described_class.new(invalid_header)  }

      it 'raises InvalidToken error' do
        expect { invalid_request_obj.call }.to raise_error(
            ExceptionHandler::InvalidToken, 'Invalid token'
        )
      end
    end

    context 'expired token' do
      let!(:expired_header) { { 'Authorization' => expired_token_generator(user.id) } }
      let!(:invalid_request_obj) { described_class.new(expired_header) }

      it 'raises InvalidToken error' do
        expect { invalid_request_obj.call }.to raise_error(
            ExceptionHandler::InvalidToken, 'Signature has expired'
        )
      end
    end

    context 'fake token' do
      let!(:fake_header) { { 'Authorization' => 'foobar' } }
      let!(:invalid_request_obj) { described_class.new(fake_header) }

      it 'raises InvalidToken error' do
        expect { invalid_request_obj.call }.to raise_error(
            ExceptionHandler::InvalidToken, 'Not enough or too many segments'
        )
      end
    end
  end
end