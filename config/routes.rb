Rails.application.routes.draw do

  root 'pages#home'

  devise_for 	:users, 
  						:path => '', 
  						:path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
  						:controllers => {:omniauth_callbacks => 'omniauth_callbacks'
  														}

  resources :users, only: [:show]
  resources :tools
  resources :photos 

  resources :tools do 
  	resources :reservations, only: [:create]
  end 

  resources :conversations, only: [:index, :create] do 
    resources :messages, only: [:index, :create]
  end 

  get '/preload' => 'reservations#preload'
  get '/preview' => 'reservations#preview'

  get '/your_rentals' => 'reservations#your_rentals'
  get '/your_reservations' => 'reservations#your_reservations'
  get '/search' => 'pages#search'
end
