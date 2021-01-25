class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  # ログイン後アクション
  def after_sign_in_path_for(resource)
    restaurants_path
  end

  # ログアウト後アクション
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  # deviseからUserデータ登録時にnameの項目も追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :release])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :release])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :release])
  end
end
