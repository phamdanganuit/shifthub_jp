# config/routes.rb
Rails.application.routes.draw do

  # 1. Handle OmniAuth callbacks OUTSIDE of the locale scope.
  # This route definition will handle URLs like /users/auth/google_oauth2/callback
  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # 2. Wrap all other routes, including the rest of Devise's routes,
  # inside the dynamic locale scope.
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    
    # This will handle locale-scoped URLs like /en/users/sign_in
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      # We still need to specify other controllers if we customize them later
      # For now, this is enough.
    }

    # ==> APPLICATION ROUTES
    root "pages#home"

    # Health check route
    get "up" => "rails/health#show", as: :rails_health_check
  end
end