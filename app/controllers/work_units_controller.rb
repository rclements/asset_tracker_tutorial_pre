class WorkUnitsController < ApplicationController
  before_filter :handle_overtime_hours_type, :only => [:create]
  before_filter :load_new_work_unit, :only => [:new, :create]
  before_filter :load_work_unit, :only => [:show, :edit, :update]
  before_filter :require_access

  protected

  def handle_overtime_hours_type
    # We send this in as a silly select field instead of a checkbox.
    params[:work_unit][:overtime] = params[:hours_type] == 'Overtime'
  end

  def load_new_work_unit
    _params = (params[:work_unit] || {}).dup
    _params.delete :client_id
    _params.delete :project_id
    @work_unit = WorkUnit.new(_params)
    @work_unit.user = current_user
    @work_unit.scheduled_at ||= Time.zone.now
  end

  def load_work_unit
    @work_unit = WorkUnit.find(params[:id])
  end

  public

  def new
  end

  def create
    if @work_unit.save
      if request.xhr?
        render :json => "{\"success\": true}", :layout => false, :status => 200 and return
      end
      flash[:notice] = t(:work_unit_created_successfully)
      redirect_to dashboard_path and return
    else
      if request.xhr?
        render :json => @work_unit.errors.full_messages.to_json, :layout => false, :status => 406 and return
      end
      flash[:error] = t(:work_unit_created_unsuccessfully)
      redirect_to dashboard_path and return
    end
  end

  def show
  end

  def edit
  end

  def update
    if @work_unit.update_attributes(params[:work_unit])
      flash[:notice] = t(:work_unit_updated_successfully)
      redirect_to @work_unit
    else
      flash.now[:error] = t(:work_unit_updated_unsuccessfully)
      redirect_to edit_work_unit_path
    end
  end

  private

  def require_access
    unless @work_unit.allows_access?(current_user)
      flash[:notice] = "Access denied."
      redirect_to root_path
    end
  end
end
