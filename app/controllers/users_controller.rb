class UsersController < ApplicationController
  before_filter :load_user, :only => [:show, :edit, :historical_time]

  def index
    @users = User.unlocked
  end

  def show
  end

  def edit
  end

  def change_password
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.save
    if @user.valid?
      flash[:notice] = "Successfully updated password"
      redirect_to :action => "edit"
    else
      flash.now[:error] = "Error changing password"
      render :action => "edit"
    end
  end

  def historical_time
    @user = User.find(params[:id])
  end

  protected

    def load_user
      if current_user.has_role?("Admin")
        @user = User.find params[:id]
      else
        @user = current_user
      end
    end

end
