class Dashboard::BaseController < ApplicationController
  respond_to :html, :json, :js
  before_filter :load_work_units, :only => [:index, :recent_work]

  protected
  def load_work_unit_bucket
    @work_unit_bucket = WorkUnit.for_user current_user
  end

  def show_message(title, message)
    @show_message = "true" unless Rails.env.test?
    @title = title
    @message = message
  end

  def load_work_units
    load_work_unit_bucket
    @clients = Client.all
    @projects ||= []
    @tickets ||= []
    if params[:date].present?
      @start_date = Date.parse(params[:date]).beginning_of_week
    else
      @start_date = Date.today.beginning_of_week
    end
    @work_units = @work_unit_bucket.scheduled_between(@start_date.beginning_of_day, 
                          (@start_date + 6.days).end_of_day).order('scheduled_at DESC')
  end

  public
  def index
    if current_user.work_units_for_day(Date.today.prev_working_day).empty?
      show_message("Laird says...", "You have not entered any time for yesterday. You're fired!")
    end

    @projects ||= []
    @tickets  ||= []
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
