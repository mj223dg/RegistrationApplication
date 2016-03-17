Rails.application.routes.draw do

  root 'home#index'
  get    'home'    => 'home#index'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :apps
  resources :users

end
