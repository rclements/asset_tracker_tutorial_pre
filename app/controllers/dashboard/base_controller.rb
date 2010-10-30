class Dashboard::BaseController < ApplicationController
  respond_to :html, :json, :js
  before_filter :load_work_units, :only => [:index, :recent_work]

  protected
  def load_work_unit_bucket
    @work_unit_bucket = WorkUnit.for_user current_user
  end

  def show_message(title, message)
    @show_message = "true"
    @title = title
    @message = message
  end

  def load_work_units
    load_work_unit_bucket
    @clients = Client.all

    @projects ||= []
    @tickets ||= []
    zone = Time.zone
    now  = zone.now

    if params[:date].present?
      @beg_date =  zone.parse( params[:date] ).at_beginning_of_week
      @end_date =  [ Time.zone.now, zone.parse( params[:date] ).at_end_of_week ].min
    else
      @beg_date = now.beginning_of_week
      @end_date = [ Time.zone.now, now.end_of_day].min
    end

    @work_units = @work_unit_bucket.scheduled_between(@beg_date.beginning_of_day, @end_date.end_of_day).order('scheduled_at DESC')
    @days       = @beg_date.to_date..@end_date.to_date

    #TODO Helper(s)
    @range      = "#{@beg_date.strftime("%m/%d/%Y")} to #{@end_date.strftime("%m/%d/%Y")} (#{@work_units.count}, #{@work_units.sum(:hours)})"

    @prev_date = (@beg_date.beginning_of_week - 1.week).strftime("%F")
    @next_date = (@end_date.beginning_of_week + 1.week).strftime("%F")
  end

  public
  def index
    if current_user.work_units_for_day(Date.today.prev_working_day).empty?
      show_message("Laird says...", "You have not entered any time for yesterday. You're fired!")
    end

    @projects ||= []
    @tickets  ||= []
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

  def recent_work
    render :partial => "shared/recent_work", :layout => false
  end
end
