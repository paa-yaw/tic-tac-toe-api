module ExceptionHandler
  extend ActiveSupport::Concern
  
  class AuthenticationError < StandardError; end 
  class InvalidToken < StandardError; end
  class MissingToken < StandardError; end 
   
  included do 
    rescue_from ActiveRecord::RecordNotFound, with: :four_o_four
    rescue_from ActiveRecord:RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two    
  end

  
  private 

  def four_twenty_two(e)
    json_response({ e.message }, :unprocessable_entity)
  end

  def four_o_four(e)
    json_response({ e.message }, :not_found)
  end

  def unauthorized_request(e)
    json_response({ e.message }, :unauthorized)
  end
end