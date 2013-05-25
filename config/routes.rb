Crewservicer::Application.routes.draw do
  root to: 'dashboard#index', as: :dashboard

  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login/redirect' => 'sessions#create', as: :oauth_redirect
  get 'login/callback' => 'sessions#callback', as: :oauth_callback

  get 'mat' => 'dashboard#food_services', as: :food_services

  scope path_names: { :new => "ny", :edit => "redigera" } do
    namespace :admin do
      resources :people, only: [ :index, :show ], path: 'folk' do
        collection do
          get 'search', path: 'sok'
        end
      end

      resources :events, only: [ :index ], path: 'event' do
        collection do
          post 'import', path: 'importera'
        end
      end

      resources :food_services, path: "maltider"
    end
  end

  match '404' => 'errors#not_found'
  match '422' => 'errors#change_rejected'
  match '500' => 'errors#server_error'
end
