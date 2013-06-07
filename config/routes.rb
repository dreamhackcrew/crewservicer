Crewservicer::Application.routes.draw do
  root to: 'dashboard#index', as: :dashboard

  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login/redirect' => 'sessions#create', as: :oauth_redirect
  get 'login/callback' => 'sessions#callback', as: :oauth_callback

  get 'mat' => 'dashboard#food_services', as: :food_services

  scope path_names: { :new => "ny", :edit => "redigera" } do
    namespace :admin do
      resources :people, only: [ :index, :show, :update ], path: 'folk' do
        member do
          post 'pick_up_t_shirt', path: 'hamta-t-shirt'
          post 'check_in', path: 'checka-in'
        end

        collection do
          get 'search', path: 'sok'
        end
      end

      resources :events, only: [ :index ], path: 'event' do
        collection do
          post 'import', path: 'importera'
        end
      end

      resources :food_services, except: [ :edit ], path: "maltider"

      resources :radio_orders, path: 'radiobestallningar' do
        member do
          post 'pickup', path: 'hamta'
          post 'next_loan_status', path: 'nasta-status'
        end

        resources :radio_loans, only: [ :show ], path: 'radios' do
          member do
            post 'bind_radio', path: 'koppla-radio'
          end
        end
      end

      resources :radios, only: [ :index ]

      resources :t_shirt_orders, only: [ :index ], path: 't-shirts'

      resources :messages, except: [ :edit ], path: "meddelanden" do
        collection do
          post 'sort', path: 'sortera'
        end

        member do
          post 'publish', path: 'publicera'
          post 'restore', path: 'aterstall'
        end
      end
    end
  end

  match '404' => 'errors#not_found'
  match '422' => 'errors#change_rejected'
  match '500' => 'errors#server_error'
end
