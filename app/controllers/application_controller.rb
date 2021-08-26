class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  before_action :skip_session

  protected def skip_session
    request.session_options[:skip] = true
  end
end
