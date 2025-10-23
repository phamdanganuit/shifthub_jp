# app/controllers/users/omniauth_callbacks_controller.rb

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    handle_auth("Google")
  end

  def line
    handle_auth("LINE")
  end

  private

  def handle_auth(kind)
   
    # request.env['omniauth.auth'] contains the user's data from the provider
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      # If the user is found and saved, sign them in and redirect
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      # If the user is new and validations fail, store the data and redirect to sign up
      session["devise.#{kind.downcase}_data"] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end
end