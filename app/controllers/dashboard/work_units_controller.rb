class Dashboard::WorkUnitsController < Dashboard::BaseController
  before_filter :load_work_units,    :only => [:index, :create]
  before_filter :load_new_work_unit, :only => [:index, :create]

  protected
  def load_work_units
    bucket = WorkUnit
    if params[:start_date] && params[:end_date]
      start_date = Time.zone.parse(params[:start_date])
      end_date = Time.zone.parse(params[:end_date]).end_of_day
      bucket = bucket.scheduled_between(start_date, end_date)
    end
    @work_units = bucket.all
  end

  def load_new_work_unit
    _params = (params[:work_unit] || {}).dup
    _params.delete :client_id
    _params.delete :project_id
    @work_unit = WorkUnit.new(_params)
    @work_unit.user = current_user
    @work_unit.ticket = Ticket.find_by_id _params["ticket_id"]
    @work_unit.scheduled_at ||= Time.zone.now
  end

  public

  def index
  end

  def show
    @work_unit = WorkUnit.find params[:id]
    @ticket = @work_unit.ticket
    @project = @ticket.project
    @client = @project.client
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
end
