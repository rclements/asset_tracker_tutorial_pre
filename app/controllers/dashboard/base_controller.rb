class Dashboard::BaseController < ApplicationController
  respond_to :html, :json, :js

  def index
    if current_user.work_units_for_day(1.day.ago).empty?
      show_message("Laird says...", "You have not entered any time for yesterday. You're fired!")
    end

    @work_units = WorkUnit.joins(:user).where('user_id = ? AND scheduled_at > ?', current_user, 8.days.ago).reverse
    @days = @work_units.map{ |wu| wu.scheduled_at.strftime("%A, %B %d, %Y") }.uniq
    @clients = Client.all

    @projects ||= []
    @tickets ||= []
  end

  def client
    @projects = Project.find(:all, :conditions => ['client_id = ?', params[:id]])
    respond_with @projects
  end

  def project
    @tickets = Ticket.find(:all, :conditions => ['project_id = ?', params[:id]])
    respond_with @tickets
  end

private
  def show_message(title, message)
    @show_message = "true"
    @title = title
    @message = message
  end

end
