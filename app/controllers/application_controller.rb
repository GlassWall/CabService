class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler
  include Haversines
  protect_from_forgery with: :null_session
end
