class HostOauthenticatesController < ApplicationController
  def create
    callback_for params[:provider]
  end

  def callback_for(provider)
    @host = Host.find_oauth(request.env["omniauth.auth"])
    if @host.persisted?
      *args = {event: :authentication}
      p options  = args.extract_options!
      p scope    = Devise::Mapping.find_scope!(@host)
      p resource = args.last || @host
      p options2 = [resource, options].extract_options!
      p options2[:bypass]
      p resource = [resource, options].last || scope
      sign_in_and_redirect @host, event: :authentication
      p current_host
      p current_user
      flash[:notice] = "ログインに成功しました。"
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to signup_registration_path
    end
    
  end

  def failure
    redirect_to root_path and return
  end
end
