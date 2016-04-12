require 'api_constraints'
Rails.application.routes.draw do
  mount Knock::Engine => '/knock'

  root 'home#index'
  get    'home'    => 'home#index'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :apps
  resources :users
  resources :hello

  namespace :api, defaults: {format: "json"} do
    scope module: :v1 do


      resources :events do
        resources :tags, only: [:index, :create]
      end
      resources :tags, only: [:index, :show]
      resources :positions, only: [:index, :show]
      resources :creators, only: [:index, :show] do
        resources :events, only: [:index]
      end
    end
  end
end