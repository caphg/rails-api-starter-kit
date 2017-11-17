Rails.application.routes.draw do
  default_url_options :host => Rails.application.config.action_mailer.default_url_options
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :vehicles
    end
  end
end
