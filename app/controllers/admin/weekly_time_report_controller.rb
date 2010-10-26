class Admin::WeeklyTimeReportController < ApplicationController

  def index
    redirect_to('/admin/weekly_time_report/0')
  end

  def show
    @users = User.where('locked_at IS NULL')

    @weekdays = []
    (0..4).each do |day|
      @weekdays << (Time.now - params[:id].to_i.weeks).beginning_of_week + day.days
    end
  end

end
