#ALERT: CSRFの脆弱性があるのでgetリクエストは禁止すべき。ただ現状Gemが対応していないものがあるので以下のようにする。
OmniAuth.config.allowed_request_methods = [:get, :post]
# OmniAuth.config.silence_get_warning = true
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.credentials.twitter[:twitter_api_key], Rails.application.credentials.twitter[:twitter_api_secret]
  provider :github, Rails.application.credentials.github[:github_client_id], Rails.application.credentials.github[:github_client_secret]
  provider :google_oauth2, Rails.application.credentials.google[:google_client_id], Rails.application.credentials.google[:google_client_secret]
end
