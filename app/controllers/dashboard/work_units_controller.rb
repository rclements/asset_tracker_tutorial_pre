class Dashboard::WorkUnitsController < Dashboard::BaseController
  def index
    @work_units = WorkUnit.all
  end
end
