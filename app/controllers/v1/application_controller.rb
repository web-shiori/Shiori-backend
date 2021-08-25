class V1::ApplicationController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  # 死活監視用エンドポイント
  def heartbeat
    render json: { "status": "alive" }
  end
end
