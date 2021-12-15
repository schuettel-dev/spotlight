Rails.application.routes.draw do
  devise_for :users
  root to: 'todays#show'

  resources :light_requests, only: %i[create destroy]
  get :remove_light_request, to: 'light_requests#destroy'

  namespace :admin do
    resource :configuration, only: :show

    resources :request_deadlines, only: %i[index update] do
      put :toggle_active, on: :member
    end
  end
end
