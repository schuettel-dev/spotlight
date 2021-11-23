Rails.application.routes.draw do
  devise_for :users
  root to: 'todays#show'

  resources :light_requests, only: %i[create destroy]

  namespace :admin do
    resource :configuration, only: :show
  end
end
