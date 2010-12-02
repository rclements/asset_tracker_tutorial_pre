class Admin::UnenteredTimeReportController < ApplicationController

  def index
    monday = Time.now.beginning_of_week.strftime("%F")
    redirect_to('/admin/unentered_time_report/' + monday)
  end

  def show
    @day = Time.parse(params[:id])

    # TODO don't we have a helper for this?
    if !@day.monday?
      monday = @day.beginning_of_week.strftime("%F")
      redirect_to('/admin/unentered_time_report/' + monday)
    end

    @users = User.unlocked
    # users should have role 'developer': we don't want to show non-entered time for 'admin' or 'client user accounts'

    # TODO way too many instance variables
    @weekdays = []
    (0..4).each do |day|
      @weekdays << @day.beginning_of_week + day.days
    end

    @previous_week = (@day.beginning_of_week - 1.week).strftime("%F")
    @beginning_of_week = @day.beginning_of_week
    @end_of_week = @day.end_of_week
    @next_week = (@day.next_week).strftime("%F")
  end

end
