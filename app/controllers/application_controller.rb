class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  helper_method :current_user

  after_filter :set_access_control_headers
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = 'GET'
  end

  private

  def require_login
    if current_user || request.url.include?("update_views_for_technology")
      return
    end    
  
    redirect_to welcome_url
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
