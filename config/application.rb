# config/application.rb

module Furima40042
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.to_prepare do
      Devise::RegistrationsController.before_action :configure_sign_up_params, only: [:create]
    end
  end
end

