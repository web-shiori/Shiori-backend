OmniAuth.config.allowed_request_methods = [:get, :post]
# OmniAuth.config.silence_get_warning = true
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.credentials.twitter[:twitter_api_key], Rails.application.credentials.twitter[:twitter_api_secret]
end
