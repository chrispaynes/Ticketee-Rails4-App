class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  # Ensures all controller actions run the authorize and policy_scope methods
  # Does not call the after_action on Devise's controllers
  after_action :verify_authorized, except: [:index],
    unless: :devise_controller?
  after_action :verify_policy_scoped, only: [:index],
    unless: :devise_controller?

  protect_from_forgery with: :exception

  # Redirects user to root path if they receive a not authorized error
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  def not_authorized
    redirect_to root_path, alert: "You aren't allowed to do that."
  end
end
