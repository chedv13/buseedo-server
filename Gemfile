source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'active_admin_import', '~> 3.1'
gem 'active_skin', '~> 0.0.12'
gem 'activeadmin', '~> 1.2.1'
gem 'activeadmin_froala_editor', '~> 0.1.2'
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'
gem 'commonmarker', '~> 0.17.9'
gem 'countries', '~> 2.1', '>= 2.1.4', require: 'countries/global'
gem 'devise_token_auth', '~> 0.1.42'
gem 'execjs', '~> 2.7'
gem 'faker', '~> 1.8.4'
gem 'graphql', '~> 1.7', '>= 1.7.13'
gem 'graphql-docs', '~> 1.5.0'
gem 'high_voltage', '~> 3.1.0'
gem 'html-pipeline', '~> 2.8.3', '>= 2.8.3'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'koala', '~> 3.0'
gem 'oj', '~> 3.3', '>= 3.3.5'
gem 'omniauth', '~> 1.6', '>= 1.6.1'
gem 'omniauth-twitter', '~> 1.4'
gem 'paperclip', '~> 5.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rack-cors', '~> 1.0', '>= 1.0.1', require: 'rack/cors'
gem 'rails', '~> 5.1.4'
gem 'sass-rails', '~> 5.0'
gem 'seed-fu', '~> 2.3.7'
gem 'sentry-raven', '~> 2.7', '>= 2.7.3'
gem 'turbolinks', '~> 5'
# TODO: Посмотреть точно ли он нужен?
gem 'typhoeus', '~> 1.3'
gem 'uglifier', '>= 1.3.0'

gem 'graphql-query-resolver'
gem 'search_object'
gem 'search_object_graphql'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop', '~> 0.52.1'
  gem 'rubocop-rspec', '~> 1.22', '>= 1.22.2'

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'capistrano', '~> 3.10'
  gem 'capistrano-rails', '~> 1.3.1'
  gem 'capistrano-bundler', '~> 1.3.0'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'graphiql-rails'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end
