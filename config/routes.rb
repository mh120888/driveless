Driveless::Application.routes.draw do

  get "profiles/show"

  devise_for :users

  devise_scope :user do
    get :register, to: 'devise/registrations#new', as: :register
    get :login, to: 'devise/sessions#new', as: :login
    get :logout, to: 'devise/sessions#destroy', as: :logout
    get :feed, to: 'statuses#index', as: :feed
  end

  resources :statuses

  root to: "statuses#index"

end
