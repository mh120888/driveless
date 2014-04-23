Driveless::Application.routes.draw do

  resources :fillups


# ========== devise ==========

  as :user do
    get :register, to: 'devise/registrations#new', as: :register
    get :login, to: 'devise/sessions#new', as: :login
    get :logout, to: 'devise/sessions#destroy', as: :logout
  end

  devise_for :users

  as :user do
    get '/login', to: 'devise/sessions#new', as: :new_user_session
    post '/login' => 'devise/sessions#create', as: :user_session
    delete '/logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

# ========== statuses ==========

  resources :statuses
  
  get :feed, to: 'statuses#index', as: :feed

# ========== user_friendships ==========

  resources :user_friendships

# ========== custom routes ==========

  get "profiles/show"

  get "/bicycle", to: 'welcome#bicycle'

  get '/bicycle/calculator', to: 'bicycle#calculator'

  get "/:id", to: 'profiles#show', as: :profile

# ========== homepage ==========

  root to: "welcome#index"

end
