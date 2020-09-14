class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :put_value_in_job, only: [:show, :edit, :update, :destroy]
  before_action :current_user_check, only: [:edit, :update, :destroy]

  def index
    @jobs = Job.search(params[:search]).includes(:user).paginate(page: params[:page])
  end

  def new
    @job = Job.new
  end

  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      flash[:success] = "求人を作成しました。"
      redirect_to @job
    else
      render 'jobs/new'
    end
  end

  def show
    @user = @job.user
  end

  def edit
  end

  def update
    if @job.update(job_params)
      flash[:success] = "求人を更新しました。"
      redirect_to @job
    else
      render 'jobs/edit'
    end
  end

  def destroy
    @job.destroy
    flash[:success] = "求人を削除しました。"
    redirect_to root_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :pay, :explanation)
  end

  def put_value_in_job
    unless @job = Job.find_by(id: params[:id])
      flash[:danger] = "求人が存在しません。"
      redirect_to root_path
    end
  end

  def current_user_check
    unless current_user == @job.user
      flash[:danger] = "権限の無い行為です。"
      redirect_to root_path
    end
  end
end
