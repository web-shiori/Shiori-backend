require 'devise_token_auth'
Rails.application.routes.draw do
  get '/heartbeat' => 'v1/application#heartbeat'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  namespace :v1, {format: 'json'} do
    resources :content, only: %i[index create update destroy]
    resources :folder, only: %i[index create update destroy]
    get '/folder/:id/content' => 'folder#content_list'
    post '/folder/:id/content/:content_id' => 'folder#add_content_to_folder'
    delete '/folder/:id/content/:content_id' => 'folder#remove_content_to_folder'
    mount_devise_token_auth_for 'User', at: 'auth', controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, via: %i[get post]
  end
end
