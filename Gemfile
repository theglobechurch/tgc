source "https://rubygems.org"

gem 'active_model_serializers', '~> 0.10.0' # Return nicely formatted JSON when required
gem 'devise'                                # User authentication
gem 'dragonfly', '~> 1.1.3'                 # File uploads
gem 'pg'                                    # Talk to the database
gem 'puma', '~> 3.7'                        # server
gem 'rails', '~> 5.1.2'                     # Ruby on rails framework
gem 'state_machines-activerecord'           # Allow models to have states (draft, published, deleted, etc)

group :development, :test, :build do
  gem 'factory_girl_rails'  # For testing
  gem 'rubocop'             # Enforce styles
  gem 'timecop'             # Test time cases
  gem 'brakeman'            # security warnings
  gem 'dotenv-rails'        # Env vars from .env file
  gem 'bundler-audit'       # Beware of outdated gems
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
