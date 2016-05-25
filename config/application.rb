require File.expand_path('../boot', __FILE__)

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module NewGradRubyChallenge
  class Application < Rails::Application
    config.generators do |g|
      g.template_engine = :slim
      g.helper_specs = false
      g.view_specs = false
      g.factory_girl dir: 'spec/factories'
    end
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %W(#{config.root}/app/channels)
    config.assets.precompile += ['*.js']
    config.assets.paths << "#{Rails}/assets/fonts"
    # config.assets.paths << "#{Rails}/assets/fonts"
  end
end
