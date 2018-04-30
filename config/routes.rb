Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  constraints subdomain: /api$/ do
    namespace :api, path: '/' do
      namespace :v1 do
        mount_devise_token_auth_for 'User', at: 'auth'

        devise_scope :user do
          scope :auth do
            post 'facebook' => 'registrations#create_from_facebook'
          end
          post 'sessions' => 'sessions#create', as: 'login'
        end

        if Rails.env.development?
          mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/v1/graphql'
        end

        post '/graphql', to: 'graphql#execute'

        resources :courses, only: %i[index show]
        resources :countries, only: :index

        resources :users, only: %i[create update] do
          resources :courses, only: %i[index]
          resources :user_tasks, path: :tasks, only: :update
        end

        resources :user_tasks, only: [] do
          resources :decisions, only: :create
          resources :user_task_intervals, path: :intervals, only: %i[create update]
        end
      end
    end
  end

  resources :subscribers, only: %i[create show], defaults: { format: 'json' }

  root to: 'welcome#index'
end
