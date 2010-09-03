class Dashboard::WorkUnitsController < Dashboard::BaseController
  before_filter :load_work_units,    :only => [:index, :create]
  before_filter :load_new_work_unit, :only => [:index, :create]

  protected
  def load_work_units
    @work_units = WorkUnit.all
  end

  def load_new_work_unit
    @work_unit = WorkUnit.new(params[:work_unit])
    @work_unit.scheduled_at ||= Time.zone.now
  end

  public
  def index
  end

  def create
    if @work_unit.save
      flash[:notice] = "Work Unit was created successfully."
      redirect_to dashboard_work_units_path
    else
      flash.now[:error] = "There wasw a problem creating the work unit"
      render :action => :index
    end
  end
end
