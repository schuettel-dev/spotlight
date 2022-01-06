if Rails.env.development?
  settings_reloader = ActiveSupport::FileUpdateChecker.new(['config/settings.yml']) do
    Rails.application.config.settings = Rails.application.config_for(:settings)
  end

  ActiveSupport::Reloader.to_prepare do
    settings_reloader.execute_if_updated
  end
end
