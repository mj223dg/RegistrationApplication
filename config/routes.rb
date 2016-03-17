Rails.application.routes.draw do

  get 'sessions/new'

  root 'sessions#new'
  get    'home'    => 'home#index'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users

end
