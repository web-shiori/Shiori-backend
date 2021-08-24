Rails.application.routes.draw do
  namespace :v1, {format: 'json'} do
    resources :content, only: %i[index create update destroy]
  end
end
