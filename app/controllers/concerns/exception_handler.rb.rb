# app/controllers/concerns/exception_handler.rb
module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response(e)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error_response(e)
    end
  end

  private
 
  def error_response(e)
    json_response(
              { 
                "status": "failure",
                "reason": e.message 
              }, :bad_request)
  end
end