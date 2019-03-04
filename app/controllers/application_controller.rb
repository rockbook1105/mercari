class ApplicationController < ActionController::Base
  # http_basic_authenticate_with name: Rails.application.credentials.basic_auth[:user_name].to_s, password: Rails.application.credentials.basic_auth[:password].to_s
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
