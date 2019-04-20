Rails.application.routes.draw do
  root to: "home#index"
  devise_scope :user do
    get "/auth/facebook/callback" => "user_oauthenticates#create"
    get "/auth/google_oauth2/callback" => "user_oauthenticates#create"
  end
  devise_for :users
  devise_scope :host do
    get "/auth/facebook_host/callback" => "host_oauthenticates#create"
    get "/auth/google_oauth2_host/callback" => "host_oauthenticates#create"
  end
  devise_for :hosts
end
