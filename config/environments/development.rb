Rails.application.configure do
  # Settings specified here override config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.reload_classes_only_on_change = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = true

  # Mailer
  config.action_mailer.default_url_options = {host: 'localhost', port: 3000}
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::FileUpdateChecker

  # Disable asset cache store
  # https://guides.rubyonrails.org/asset_pipeline.html#assets-cache-store
  config.assets.configure do |env|
    env.cache = ActiveSupport::Cache.lookup_store(:null_store)
  end
end
