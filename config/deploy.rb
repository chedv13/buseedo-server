# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'buseedo'
# set :repo_url, 'https://copadrop-deployer:kqoJOl6yz0G7K3A@github.com/chedv13/buseedo-server'
set :repo_url, 'https://github.com/chedv13/buseedo-server.git'
set :deploy_to, '/opt/buseedo'
set :keep_releases, 5
set :pty, true
set :use_sudo, false
set :rvm_ruby_version, '2.4.1'
set :linked_dirs, fetch(:linked_dirs, []).push('public/system')
set :default_env, { PASSENGER_INSTANCE_REGISTRY_DIR: '/tmp' }

# namespace :deploy do
#   after :finishing, :notify do
#     on roles(:web), in: :groups do
#       within release_path do
#         execute :rake, 'create_graphql_docs'
#       end
#     end
#   end
# end
