class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :set_active_storage_url_options  
  before_action :configure_sign_up_params, only: [:create], if: :devise_controller?
  before_action :authenticate_user!, except: :index
  before_action :redirect_if_not_item_owner, only: [:edit]

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
  def authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path, alert: 'You need to sign in before editing items.'
    end
  end


  def set_active_storage_url_options
    ActiveStorage::Current.url_options = {
      host: request.base_url
    }
  end
  def redirect_if_not_item_owner
    @item = Item.find(params[:item_id])
  
    puts "Current User: #{current_user.inspect}"
    puts "Item Owner: #{@item.user.inspect}"
  
    return if user_signed_in? && current_user == @item.user
  
    if @item.sold_out?
      redirect_to root_path, alert: 'この商品は売り切れています'
    else
      # ログアウト状態の場合、ログインページにリダイレクト
      redirect_to new_user_session_path, alert: 'ログインが必要です'
    end
  end
end
