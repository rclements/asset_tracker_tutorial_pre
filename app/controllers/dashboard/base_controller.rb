class Dashboard::BaseController < ApplicationController
  before_filter :get_calendar_details, :only => [:index, :calendar]
  before_filter :load_all_projects, :only => [:index]
  before_filter :load_all_tickets, :only => [:index]
  respond_to :html, :json, :js

  def load_all_projects
    # TODO need a better/cleaner way to do the following conditional for all the methods in this controller
    if admin?
      @projects = Project.all
    else
      @projects = Project.all.select {|p| p.allows_access?(current_user) }
    end
  end

  def load_all_tickets
    if admin?
      @tickets = Ticket.all
    else
      @tickets = Ticket.all.select {|t| t.allows_access?(current_user) }
    end
  end
  public

  def index
    if current_user.work_units_for_day(Date.today.prev_working_day).empty? && !Rails.env.test?
      @message = {:title => t(:management), 
        :body => t(:enter_time_for_previous_day)}
    end

    if admin?
      @clients = Client.all
    else
      @clients = Client.all.select {|c| c.allows_access?(current_user) }
    end
    @tickets  ||= []
  end

  def client
    if admin?
      @projects = Project.find(:all, :conditions => ['client_id = ?', params[:id]])
    else
      @projects = Project.find(:all, :conditions => ['client_id = ?', params[:id]]).select {|p| p.allows_access?(current_user) }
    end
    respond_with @projects
  end

  def project
    if admin?
      @tickets = Ticket.find(:all, :conditions => ['project_id = ?', params[:id]])
    else
      @tickets = Ticket.find(:all, :conditions => ['project_id = ?', params[:id]]).select {|t| t.allows_access?(current_user) }
    end
    respond_with @tickets
  end

  def calendar
  end

  private
  def get_calendar_details
    if params[:date].present?
      @start_date = Date.parse(params[:date]).beginning_of_week
    else
      @start_date = Date.today.beginning_of_week
    end
  end
end
