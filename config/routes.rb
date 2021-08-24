Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  devise_for :users
  namespace :v1, {format: 'json'} do
    resources :content, only: %i[index create update destroy]
  end
end
