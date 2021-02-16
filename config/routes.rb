Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  get '/restaurants/return', to: 'restaurants#return'
  delete 'post_image_delete/:id', to: 'posts#img_destroy', as: 'post_img_destroy'
  resources :restaurants
  resources :posts
  root 'static_pages#home'
  get  '/about', to: 'static_pages#about'
  
end
