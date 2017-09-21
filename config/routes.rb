Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  constraints subdomain: 'api' do
    namespace :api, path: '/' do
      namespace :v1 do
        devise_scope :user do
          post 'registrations' => 'registrations#create', :as => 'register'
          post 'sessions' => 'sessions#create', :as => 'login'
          delete 'sessions' => 'sessions#destroy', :as => 'logout'
        end

        resources :users, only: [:index, :show] do
          resources :days, only: [:index] do
            resources :tasks, only: [:index]
          end
        end
      end
    end
  end
end
