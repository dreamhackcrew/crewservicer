Crewservicer::Application.routes.draw do
  root to: 'dashboard#index', as: :dashboard

  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login/redirect' => 'sessions#create', as: :oauth_redirect
  get 'login/callback' => 'sessions#callback', as: :oauth_callback

  resources :people, only: [ :index, :show ] do
    collection do
      get 'search'
    end
  end

  resources :events, only: [ :index ] do
    collection do
      post 'import'
    end
  end
end
