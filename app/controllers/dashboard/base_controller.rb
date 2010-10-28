class Dashboard::BaseController < ApplicationController
  respond_to :html, :json, :js
  before_filter :load_work_units, :only => [:index, :recent_work]

  def index
    if current_user.work_units_for_day(Date.today.prev_working_day).empty?
      show_message("Laird says...", "You have not entered any time for yesterday. You're fired!")
    end

    @work_units = WorkUnit.joins(:user).where('user_id = ? AND scheduled_at > ?', current_user, 8.days.ago).reverse
    @days = @work_units.map{ |wu| wu.scheduled_at.strftime("%A, %B %d, %Y") }.uniq
    @clients = Client.all

    @projects ||= []
    @tickets ||= []
    
    @start_date = Date.today.beginning_of_week
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

  def load_work_units
    @clients = Client.all

    @projects ||= []
    @tickets ||= []

    if params[:date].present?
      @beg_date=  Time.zone.parse( params[:date] ).at_beginning_of_week.strftime("%F")
      @end_date =  Time.zone.parse( params[:date] ).at_end_of_week.strftime("%F")
    else
      @beg_date = Time.zone.now.beginning_of_week.strftime("%F")
      @end_date = Time.zone.now.end_of_day.strftime("%F")
    end

    @work_units = WorkUnit.joins(:user).where('user_id = ? AND scheduled_at BETWEEN ? AND ?', current_user, Time.zone.parse(@beg_date).beginning_of_day, Time.zone.parse(@end_date).end_of_day).reverse
    @days = @work_units.map{ |wu| wu.scheduled_at.strftime("%A, %B %d, %Y") }.uniq

    @range = "#{Time.zone.parse(@beg_date).strftime("%m/%d/%Y")} to #{Time.zone.parse(@end_date).strftime("%m/%d/%Y")}"

    @prev_date = (Time.zone.parse(@beg_date).beginning_of_week - 1.week).strftime("%F")
    @next_date = (Time.zone.parse(@end_date).beginning_of_week + 1.week).strftime("%F")
  end
end
