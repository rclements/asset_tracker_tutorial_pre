class Dashboard::BaseController < ApplicationController
  before_filter :get_calendar_details, :only => [:index, :calendar]
  before_filter :load_all_projects, :only => [:index]
  before_filter :load_all_tickets, :only => [:index]
  respond_to :html, :json, :js

  def load_all_projects
    @projects = current_user.assigned_projects
  end

  def load_all_tickets
    @tickets = current_user.assigned_tickets
  end
  public

  def index
    if current_user.work_units_for_day(Date.today.prev_working_day).empty? && !Rails.env.test?
      @message = {:title =>"Management", 
        :body => "You have not entered any time for the previous working day. Please Enter it immediatly!"}
    end

    @clients = current_user.admin? ? Client.all : current_user.assigned_clients
    @tickets  ||= []
  end

  def client
    @projects = Project.find(:all, :conditions => ['client_id = ?', params[:id]]) & current_user.assigned_projects
    respond_with @projects
  end

  def project
    @tickets = Ticket.find(:all, :conditions => ['project_id = ?', params[:id]]) & current_user.assigned_tickets
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
