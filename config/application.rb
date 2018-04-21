require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Buseedo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.to_prepare do
      Dir.glob(Rails.root + 'app/decorators/**/*_decorator*.rb').each do |c|
        require_dependency(c)
      end
    end

    %i[connections mutations resolvers types].each do |folder|
      config.autoload_paths += Dir["#{config.root}/app/graphql/#{folder}/**/"]
    end

    config.assets.paths << "#{Rails.root}/app/views/pages/assets"
    config.generators do |g|
      g.template_engine nil
      g.test_framework nil
      g.assets false
      g.helper false
      g.stylesheets false
    end

    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
                 :headers => :any,
                 :expose => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
                 :methods => [:get, :post, :options, :delete, :put]
      end
    end
  end
end
