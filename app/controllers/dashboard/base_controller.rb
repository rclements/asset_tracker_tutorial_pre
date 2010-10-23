class Dashboard::BaseController < ApplicationController

  def index

    if current_user.has_no_time_for(1.day.ago)
      @no_time = "true"
    end

    @work_units = WorkUnit.joins(:user).where('user_id = ? AND scheduled_at > ?', current_user, 8.days.ago)
    @days = @work_units.map{ |wu| wu.scheduled_at.strftime("%A, %B %d, %Y") }.uniq

  end

end
