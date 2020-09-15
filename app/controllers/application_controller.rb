class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :self_introduction])
  end

  def current_user_check
    unless current_user == @user
      flash[:danger] = "権限の無い行為です。"
      redirect_to root_path, status: :found
    end
  end
end
