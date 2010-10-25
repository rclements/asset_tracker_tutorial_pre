class Dashboard::BaseController < ApplicationController

  def index

    if current_user.time_for(1.day.ago).empty?
      @no_time = "true"
      @title = "Laird says..."
      @message = "You have not entered any time for yesterday. You're fired!"
    end

    @work_units = WorkUnit.joins(:user).where('user_id = ? AND scheduled_at > ?', current_user, 8.days.ago).reverse
    @days = @work_units.map{ |wu| wu.scheduled_at.strftime("%A, %B %d, %Y") }.uniq

  end

end
