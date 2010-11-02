class WorkUnitsController < ApplicationController
  before_filter :load_ticket
  before_filter :load_new_work_unit, :only => [:new, :create]
  before_filter :load_work_unit, :only => [:show, :edit, :update, :destroy]

  protected
  def load_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def load_new_work_unit
    @work_unit = WorkUnit.new(params[:work_unit])
    @work_unit.ticket = @ticket
    @work_unit.user = current_user
    @work_unit.scheduled_at ||= Time.zone.now
  end

  def load_work_unit
    @work_unit = WorkUnit.find(params[:id])
  end

  public
  def index
    @work_units = @ticket.work_units
  end

  def new
  end

  def create
    if @work_unit.save
      flash[:notice] = "WorkUnit created successfully."
      redirect_to ticket_work_unit_path(@ticket, @work_unit)
    else
      flash.now[:error] = "There was a problem saving the work_unit."
      render :action => 'new'
    end
  end

  def show
    @client = @work_unit.client
    @project = @work_unit.project
    @ticket = @work_unit.ticket
  end

  def destroy
    if @work_unit.destroy
      flash[:notice] = "WorkUnit destroyed successfully."
      redirect_to ticket_work_units_path(@ticket)
    else
      flash.now[:error] = "There was a problem destroying the work_unit."
      redirect_to ticket_work_unit_path(@work_unit, @ticket)
    end
  end

  def edit
  end

  def update
    if @work_unit.update_attributes(params[:work_unit])
      flash[:notice] = "WorkUnit updated."
      redirect_to client_project_ticket_work_unit_path(@client, @project, @ticket, @work_unit)
    else
      flash.now[:error] = "There was a problem updating the work_unit."
      redirect_to client_project_ticket_work_unit_path(@client, @project, @work_unit, @ticket)
    end
  end
end
