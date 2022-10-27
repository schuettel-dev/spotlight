Rails.application.routes.draw do
  devise_for :users
  root to: 'todays#show'

  resources :light_requests, only: %i[create destroy]
  get :remove_light_request, to: 'light_requests#destroy'

  resource :today, only: :show do
    get :status, on: :collection
  end
  resource :profile, only: %i[show update]

  namespace :admin do
    resource :configuration, only: :show
    resources :calendar_dates, only: %i[index update]
    resources :weekday_templates, only: %i[index update]
    resources :users, only: %i[index update]
  end
end
