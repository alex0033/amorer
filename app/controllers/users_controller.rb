class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    unless @user = User.find_by(id: params[:id])
      flash[:danger] = "ユーザーが存在しません"
      redirect_to root_path
    end
  end
end
