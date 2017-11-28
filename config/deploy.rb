# config valid for current version and patch releases of Capistrano
lock '~> 3.10.0'

set :application, 'buseedo'
set :repo_url, 'https://buseedo-deployer:fyOd07042aGD65L@gitlab.com/chedv13/buseedo'
set :deploy_to, '/opt/buseedo'
set :keep_releases, 5
set :pty, true
set :use_sudo, false
set :rvm_ruby_version, '2.4.1'
set :linked_dirs, fetch(:linked_dirs, []).push('public/system')
set :default_env, {
    :PASSENGER_INSTANCE_REGISTRY_DIR => '/tmp'
}