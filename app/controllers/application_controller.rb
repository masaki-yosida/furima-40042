class ApplicationController < ActionController::Base
  before_action :basic_auth

  before_action :configure_sign_up_params, only: [:create]

  def create
    @user = build_resource(sign_up_params)

    if @user.save
      # 保存成功の処理
    else
      Rails.logger.debug "User save failed. Errors: #{user.errors.full_messages}"
      # 保存失敗時の処理
    end
  end


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 環境変数を読み込む記述に変更
    end
  end
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :nickname, :firstname_kanji, :lirstname_kanji, :firstname_kana, :lastname_kana, :birthday])
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname, :firstname_kanji, :lirstname_kanji, :firstname_kana, :lastname_kana, :birthday)
  end
end