class Admin::WeeklyTimeReportController < ApplicationController

  def index
    monday = Time.now.beginning_of_week.strftime("%Y-%m-%d")
    redirect_to('/admin/weekly_time_report/' + monday)
  end

  def show
    @day = Time.parse(params[:id])

    if !@day.monday?
      monday = @day.beginning_of_week.strftime("%Y-%m-%d")
      redirect_to('/admin/weekly_time_report/' + monday)
    end

    @users = User.unlocked
    # users should have role 'developer': we don't want to show non-entered time for 'admin' or 'client user accounts'

    @weekdays = []
    (0..4).each do |day|
      @weekdays << @day.beginning_of_week + day.days
    end

    @previous_week = (@day.beginning_of_week - 1.week).strftime("%Y-%m-%d")
    @next_week = (@day.next_week).strftime("%Y-%m-%d")
  end

end
