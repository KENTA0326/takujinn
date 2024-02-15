class Public::ReportsController < ApplicationController
  before_action :authenticate_user!

  def new
    @report = Report.new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_user.id
    @report.reported_id = @user.id

    if @report.save
      flash[:notice] = "通報が送信されました。"
      redirect_to user_path(@user)
    else
      flash.now[:notice] = "通報できませんでした。文章を入力してください。"
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason)
  end

end
