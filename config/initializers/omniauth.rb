Rails.application.config.middleware.use OmniAuth::Builder do
  require 'omniauth/strategies/facebook_host'
  require 'omniauth/strategies/google_oauth2_host'
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  provider :facebook, ENV['FACEBOOK_CLIENT_ID'], ENV['FACEBOOK_CLIENT_SECRET']
  provider :facebook_host, ENV['FACEBOOK_HOST_CLIENT_ID'], ENV['FACEBOOK_HOST_CLIENT_SECRET']
  provider :google_oauth2_host, ENV['GOOGLE_HOST_CLIENT_ID'], ENV['GOOGLE_HOST_CLIENT_SECRET']

  
end