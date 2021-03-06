Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.raise_runtime_errors = true
  config.action_view.raise_on_missing_translations = true
  config.action_controller.action_on_unpermitted_parameters = :raise
  config.public_file_server.enabled = true
  config.read_encrypted_secrets = ENV["RAILS_MASTER_KEY"].present? ||
    File.exist?("config/secrets.yml.key")
end
