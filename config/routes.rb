Rails.application.routes.draw do
  devise_for :users
  namespace :v1, {format: 'json'} do
    resources :content, only: %i[index create update destroy]
  end
end
