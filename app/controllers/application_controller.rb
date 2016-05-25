class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # :nocov:
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :middle_name, :last_name, :nickname])
  end
  # :nocov:

  def after_sign_in_path_for(resource)
    channels_path
  end

  def after_sign_out_path_for(resource)
    '/users/sign_in' # サインアウト後のリダイレクト先URL
  end
end
