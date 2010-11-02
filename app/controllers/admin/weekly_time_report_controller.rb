class Admin::WeeklyTimeReportController < ApplicationController
  
  def index
    redirect_to('/admin/weekly_time_report/' + Date.today.beginning_of_week.strftime("%F"))
  end

  def show
    redirect_unless_monday('/admin/weekly_time_report/', params[:id])
    # FIXME: users should have role 'developer', we don't want to show non-entered time for non developers
    @users = User.unlocked
  end

end
