class V1::ApplicationController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

end
