Rails.application.routes.draw do
  devise_for :users
  root to: 'todays#show'

  resources :light_requests, only: %i[create destroy]
  get :remove_light_request, to: 'light_requests#destroy'

  namespace :admin do
    resource :configuration, only: :show
    resources :light_requests, only: %i[index update]
    resources :request_deadlines, only: %i[index update]
    resources :users, only: %i[index update]
  end
end
