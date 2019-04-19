Rails.application.routes.draw do
  root to: "home#index"
  devise_scope :user do
    get "/users/auth/:provider/callback" => "user2#create"
  end
  devise_for :users
end
