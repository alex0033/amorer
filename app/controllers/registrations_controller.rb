class RegistrationsController < Devise::RegistrationsController
  # パスワードなしで、変更できるようにカスタマイズ
  def update
    if @user.update(edit_params)
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to @user
    else
      render 'devise/registrations/edit'
    end
  end

  protected

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  def edit_params
    params.require(:user).permit(
      :name,
      :email,
      :self_introduction,
      :image,
      :x,
      :y,
      :width,
      :height
    )
  end
end
