require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Scoring
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    #タイムゾーン変更
    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :local

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.assets.initialize_on_precompile = false

    # バリデーとメッセージ日本語
    config.i18n.default_locale = :ja

    # SendGridを利用
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { host: 'score-club.com' }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.smtp_settings = {
        user_name: ENV['SENDGRID_USERNAME'],
        password: ENV['SENDGRID_PASSWORD'],
        domain: 'www.score-club.com',
        address: 'smtp.sendgrid.net',
        port: 587,
        authentication: :plain,
        enable_starttls_auto: true,
        :authentication => 'login'
    }
  end
end
