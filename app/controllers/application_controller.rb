class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :set_active_storage_url_options  # Add this line
  before_action :configure_sign_up_params, only: [:create], if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_sign_up_params
    if controller_name == 'registrations' && action_name == 'create'
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :nickname, :firstname_kanji, :lirstname_kanji, :firstname_kana, :lastname_kana, :birthday])
    end
  end

  def set_active_storage_url_options
    ActiveStorage::Current.url_options = {
      host: request.base_url
    }
  end
end
