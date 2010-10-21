class Admin::PayrollController < ApplicationController
  before_filter :load_users, :only => [:index]
  before_filter :load_user, :only => [:show]

  def index
  end

  def show
    @work_units = @user.work_units.where('paid = "" OR paid IS NULL')
    @clients = @work_units.collect { |wu| wu.client }.uniq
  end

  def update
    params[:work_unit].each do |key, value|
      if key =~ /\d+/
        unless value.empty?
          work_unit = WorkUnit.find(key.to_i)
          if work_unit
            work_unit.update_attributes(:paid => value)
          end
        end
      end
    end

    redirect_to admin_payroll_path
    #debugger
  end

  private

    def load_users
      # TODO: Make this logic better.
      # Only pull users who have outstanding units that need to be paid.
      @users = User.where('work_units.paid IS NULL OR work_units.paid = ""').includes(:work_units)
    end

    def load_user
      @user = User.find(params[:id])
    end

end
