class CommentsController < ApplicationController
  before_filter :set_bucket

  protected
  def set_bucket
    @comments = []
    filter_client_comments
    filter_project_comments
    filter_ticket_comments
    filter_work_unit_comments
  end

  def filter_client_comments
    if params[:client_id].present?
      @client   = Client.find_by_id(params[:client_id])
      @comments = @client.comments if @client
    end
  end

  def filter_project_comments
    if @client && params[:project_id].present?
      @project  = @client.projects.find_by_id(params[:project_id])
      @comments = @project.comments if @project
    end
  end

  def filter_ticket_comments
    if @project && params[:ticket_id].present?
      @ticket   = @project.tickets.find_by_id(params[:ticket_id])
      @comments = @ticket.comments if @ticket
    end
  end

  def filter_work_unit_comments
    if @ticket && params[:work_unit_id].present?
      @work_unit = @ticket.work_units.find_by_id(params[:work_unit_id])
      @comments  = @work_unit.comments if @work_unit
    end
  end

  public
  def index
  end

  def show
  end

  def new
  end
end
