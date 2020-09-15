class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_and_entry, only: :destroy
  before_action :current_user_check, only: :destroy

  def create
    @job = Job.find(params[:job_id])
    @user = @job.user
    @entry = current_user.entries.build(job: @job)
    @entry.save
    respond_to do |format|
      format.html { redirect_to @job }
      format.js
    end
  end

  def destroy
    @job = @entry.job
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to @job }
      format.js
    end
  end

  private

  def set_user_and_entry
    @entry = Entry.find(params[:id])
    @user = @entry.user
  end
end
