Driveless::Application.routes.draw do

# ========== devise ==========

  devise_for :users

  devise_scope :user do
    get :register, to: 'devise/registrations#new', as: :register
    get :login, to: 'devise/sessions#new', as: :login
    get :logout, to: 'devise/sessions#destroy', as: :logout
    get :feed, to: 'statuses#index', as: :feed
  end

# ========== statuses ==========

  resources :statuses

# ========== custom routes ==========

  get "profiles/show"

  get "/bicycle", to: 'welcome#bicycle'

  get '/bicycle/calculator', to: 'bicycle#calculator'

  get "/:id", to: 'profiles#show'

# ========== homepage ==========

  root to: "welcome#index"

end
