class WorkUnitsController < ApplicationController
  before_filter :load_ticket
  before_filter :load_new_work_unit, :only => [:new, :create]
  before_filter :load_work_unit, :only => [:show, :edit, :update, :destroy]
  
  protected
  def load_ticket
    if params[:ticket_id]
      @ticket = Ticket.find(params[:ticket_id])
    elsif
      @ticket = Ticket.find(params[:work_unit][:ticket_id])
    end
  end

  def load_new_work_unit
    _params = (params[:work_unit] || {}).dup
    _params.delete :client_id
    _params.delete :project_id
    @work_unit = WorkUnit.new(_params)
    @work_unit.user = current_user
    @work_unit.ticket = @ticket
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
      if request.xhr?
        render :json => "{\"success\": true}", :layout => false, :status => 200 and return
      end
      flash[:notice] = "Work Unit was created successfully."
      redirect_to dashboard_path and return
    else
      if request.xhr?
        render :json => @work_unit.errors.full_messages.to_json, :layout => false, :status => 406 and return
      end
      flash.now[:error] = "There was a problem creating the work unit"
      render :action => :index and return
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
      redirect_to ticket_work_unit_path(@ticket, @work_unit)
    else
      flash.now[:error] = "There was a problem updating the work_unit."
      redirect_to edit_ticket_work_unit_path(@ticket, @work_unit)
    end
  end
end
