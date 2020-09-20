class RegistrationsController < Devise::RegistrationsController
  def update
    super
    @user.image.attach(params[:user][:image])
  end

  protected

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
