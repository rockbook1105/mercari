class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    basic_action
  end

  def google_oauth2
    basic_action
  end

  private

  def basic_action
    @user = Authorization.find_or_create_by_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to users_sign_up_address_path(id: @user.id)
    end
  end
end
