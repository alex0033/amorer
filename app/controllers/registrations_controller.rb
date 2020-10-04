class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [
        :name,
        :self_introduction,
        :image,
        :x,
        :y,
        :width,
        :height,
      ]
    )
  end
end
