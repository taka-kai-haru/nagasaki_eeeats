Rails.application.routes.draw do
  # get 'posts/new'
  # get 'posts/edit'
  # devise_for :users, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions',
  #   :password => 'users/password',
  #   :donfimation => 'users/cofination'
  # }
  # devise_for :users, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions',
  #   :confimation => 'users/cofination'
  # }



  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  get '/restaurants/return', to: 'restaurants#return'
  resources :restaurants
  resources :posts
  root 'static_pages#home'
  get  '/about', to: 'static_pages#about'


end
