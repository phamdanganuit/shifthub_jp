# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # This callback will run before any action in any controller.
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:display_name])
  end

  private

  def set_locale
    # 1. Get locale from URL params.
    # 2. Check if it's an available locale.
    # 3. If not, fall back to the default locale.
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # This makes the :locale parameter stick to all generated URLs.
  def default_url_options
    { locale: I18n.locale }
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
