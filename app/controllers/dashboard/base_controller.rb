class Dashboard::BaseController < ApplicationController
  before_filter :get_calendar_details, :only => [:index, :calendar]
  respond_to :html, :json, :js

  def index
    unless current_user.work_units_for_day(Date.current.prev_working_day).any? || Rails.env.test? || admin?
      @message = {:title => t(:management),
        :body => t(:enter_time_for_previous_day)}
    end

    @clients = Client.for_user current_user
    @projects = Project.for_user current_user
    @tickets = Ticket.for_user current_user
  end

  def client
    @projects = Project.find(:all, :conditions => ['client_id = ?', params[:id]])
    unless admin?
      @projects = @projects.select {|p| p.allows_access?(current_user)}
    end
    respond_with @projects
  end

  def project
    @tickets = Ticket.find(:all, :conditions => ['project_id = ?', params[:id]])
    unless admin?
      @tickets = @tickets.select {|t| t.allows_access?(current_user) }
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
