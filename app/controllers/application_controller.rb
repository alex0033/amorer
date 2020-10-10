class ApplicationController < ActionController::Base
  before_action :count_messages

  after_action :delete_message_cookies, only: :destroy, if: :devise_controller?

  protected

  def current_user_check
    unless current_user == @user
      not_correct_user_action
    end
  end

  def not_correct_user_action
    flash[:danger] = "権限の無い行為です。"
    redirect_to root_path
  end

  def delete_message_cookies
    cookies.delete(NUMBER_OF_MESSAGES)
  end

  def count_messages
    if signed_in?
      cookies[NUMBER_OF_MESSAGES] ||= {
        value: current_user.count_not_read_messages,
        expires: CUSTOM_COOKIES_TIME,
      }
    end
  end

  def after_sign_in_path_for(resource)
    user_path resource
  end
end
