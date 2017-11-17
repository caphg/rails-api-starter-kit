Rails.application.routes.draw do
  default_url_options :host => Rails.application.config.action_mailer.default_url_options
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
