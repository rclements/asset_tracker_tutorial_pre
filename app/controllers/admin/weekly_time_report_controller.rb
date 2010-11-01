class Admin::WeeklyTimeReportController < ApplicationController

  def index
    monday = Time.now.beginning_of_week.strftime("%F")
    redirect_to('/admin/weekly_time_report/' + monday)
  end

  def show
    @beg_date = Time.parse(params[:id])

    if !@beg_date.monday?
      monday = @beg_date.beginning_of_week.strftime("%F")
      redirect_to('/admin/weekly_time_report/' + monday)
    end

    @users = User.unlocked
    # users should have role 'developer': we don't want to show non-entered time for 'admin' or 'client user accounts'

    @weekdays = []
    (0..6).each do |day|
      @weekdays << @beg_date.beginning_of_week + day.days
    end

    @previous_week = (@beg_date.beginning_of_week - 1.week).strftime("%F")
    @beginning_of_week = @beg_date.beginning_of_week
    @end_of_week = @beg_date.end_of_week
    @next_week = (@beg_date.next_week).strftime("%F")
  end

end
