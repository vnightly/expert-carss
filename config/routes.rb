Rails.application.routes.draw do
  # get 'work/index'
  # get 'work/choose_theme'
  # get 'work/display_theme'
  resources :themes
  resources :images
  resources :values
  resources :users
  resources :sessions
  get 'main/index'
  get 'main/help'
  get 'main/contacts'
  get 'main/about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'main#index'
  match 'work', to: 'work#index', via: :get
  match 'signup',   to: 'users#new',            via: 'get'
  match 'signin',   to: 'sessions#new',         via: 'get'
  match 'signout',  to: 'sessions#destroy',     via: 'get'


  resources :work, only: [:index] do
    collection do
      get 'next_image'
      get 'previous_image'
      post 'save_rating'
    end
  end
end
