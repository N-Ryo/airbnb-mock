class UserOauthenticatesController < ApplicationController
  def create
    callback_for params[:provider]
  end

  def callback_for(provider)
    @user = User.find_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      *args = {event: :authentication}
      p options  = args.extract_options!
      p scope    = Devise::Mapping.find_scope!(@user)
      p resource = args.last || @user
      p options2 = [resource, options].extract_options!
      p options2[:bypass]
      p resource = [resource, options].last || scope
      sign_in_and_redirect @user, event: :authentication
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
