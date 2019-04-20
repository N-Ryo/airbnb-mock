class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_host, :host_signed_in?

  private

    def current_host
      return unless session[:host_id]
      @current_host ||= Host.find(session[:host_id])
    end

    def host_signed_in?
      !!session[:host_id]
    end

    def authenticate
      return if signed_in?
      return if host_signed_in?
      redirect_to root_path, alert: 'ログインしてください'
    end
end
