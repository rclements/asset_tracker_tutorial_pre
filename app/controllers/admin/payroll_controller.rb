class Admin::PayrollController < ApplicationController
  before_filter :load_users, :only => [:index]
  before_filter :load_user, :only => [:show]

  def index
    @clients = @user.work_units.clients
    @work_units = @user.work_units
  end

  def show
  end

  private

    def load_users
      @users = User.all
      # TODO: Logic for loading users with unpaid work_units needs to be added here
    end

    def load_user
      @user = User.find(params[:id])
    end

end
