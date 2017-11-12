source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'active_skin', '~> 0.0.12'
gem 'activeadmin', '~> 1.1'
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'
# gem 'devise', '~> 4.3'
gem 'devise_token_auth', '~> 0.1.42'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'oj', '~> 3.3', '>= 3.3.5'
gem 'omniauth', '~> 1.6', '>= 1.6.1'
gem 'paperclip', '~> 5.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rack-cors', '~> 1.0', '>= 1.0.1', :require => 'rack/cors'
gem 'rails', '~> 5.1.4'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # GEms for deploy
  gem 'capistrano', '~> 3.7', '>= 3.8.1'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-bundler', '~> 1.2'
  gem 'capistrano-rvm'
  gem 'capistrano-passenger'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end
