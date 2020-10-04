class RegistrationsController < Devise::RegistrationsController
  def update
    super
    # image = params[:user][:image] || params[:user][:original_image]
    # @user.image.attach(image)
  end

  protected

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
