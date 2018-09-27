class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  helper ApplicationHelper
  
  after_action :verify_policy_scoped, unless: :devise_controller?
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:subdomain])
  end
  
end
