class Admin::WeeklyTimeReportController < ApplicationController

  def index
    redirect_to('/admin/weekly_time_report/0')
  end

  def show
    @users = User.where('locked_at IS NULL')
    # users should have role 'developer': we don't want to show non-entered time for 'admin' or 'client user accounts'

    @weekdays = []
    (0..4).each do |day|
      @weekdays << (Time.now + params[:id].to_i.weeks).beginning_of_week + day.days
    end
  end

end
