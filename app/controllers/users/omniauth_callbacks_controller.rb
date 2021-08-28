# frozen_string_literal: true

class Users::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  include DeviseTokenAuth::Concerns::SetUserByToken

  skip_before_action :skip_session

  def redirect_callbacks
    super
  end

  def omniauth_success
    super
    update_auth_header
  end

  def omniauth_failure
    super
  end

  def get_resource_from_auth_hash
    super
    set_email
  end

  def render_data_or_redirect(message, data, user_data = {})
    # render json: @resource, status: :ok
    head :ok
  end

  def set_email
    @resource.email = "#{@resource.uid}-#{@resource.provider}@example.com"
  end
end
