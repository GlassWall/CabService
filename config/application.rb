require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Restapi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')
    # ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
    # ActiveRecord::Schema.verbose = false
    # eval(`cat #{Rails.root.to_s}/db/schema.rb | sed 's/,[^:]*: :serial\//g'`)
    # puts `bin/rails db:migrate`
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
