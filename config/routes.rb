Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  constraints subdomain: 'api' do
    namespace :api, path: '/', defaults: { format: :json } do
      namespace :v1 do
        mount_devise_token_auth_for 'User', at: 'auth'


        devise_scope :user do
          scope :auth do
            post 'facebook' => 'registrations#create_from_facebook'
          end
          # post 'registrations' => 'registrations#create', :as => 'register'
          post 'sessions' => 'sessions#create', :as => 'login'
          # delete 'sessions' => 'sessions#destroy', :as => 'logout'
        end

        resources :users, only: %i[index show] do
          resources :user_tasks, only: :update do
            resources :user_time_intervals, only: :update
          end
          resources :days, only: [:index] do
            resources :tasks, only: [:index]
          end
        end
      end
    end
  end

  resources :subscribers, only: %i[create show], defaults: { format: 'json' }

  root to: 'welcome#index'
end
