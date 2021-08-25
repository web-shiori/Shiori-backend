require 'devise_token_auth'
Rails.application.routes.draw do
  get '/heartbeat' => 'v1/application#heartbeat'
  namespace :v1, {format: 'json'} do
    resources :content, only: %i[index create update destroy]
    get '/likes' => 'likes#index'
    post '/content/:content_id/like' => 'likes#create'
    delete '/content/:content_id/like' => 'likes#delete'
    mount_devise_token_auth_for 'User', at: 'auth', controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, via: %i[get post]
  end
end
