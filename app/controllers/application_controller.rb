class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  private

  def tenant
    @tenant ||= current_user.organization if user_signed_in?
  end
  helper_method :tenant
end
