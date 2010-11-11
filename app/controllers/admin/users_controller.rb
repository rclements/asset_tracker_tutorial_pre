class Admin::UsersController < Admin::BaseController
  before_filter :load_user_account, :only => [:update, :edit, :destroy]
  before_filter :load_new_user_account, :only => [:new, :create]

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user.update_attributes(params[:user])
    if @user.save
      flash[:notice] = "Created successfully"
      redirect_to admin_users_path
    else
      flash[:error] = "Didn't create."
      redirect_to new_admin_user_path
    end
  end

  def edit
  end

  def update

    if params[:user]["locked"] == "1" && !@user.locked_at?
      @user.lock_access!
    elsif params[:user]["locked"] == "0" && @user.locked_at?
      @user.unlock_access!
    end

    @user.update_attributes(params[:user])
    if @user.save
      flash[:notice] = "Updated successfully"
      redirect_to admin_user_path(@user)
    else
      flash[:error] = "Didn't update."
      redirect_to edit_admin_user_path(@user)
    end
  end

private

  def load_user_account
    @user = User.find(params[:id])
  end

  def load_new_user_account
    @user = User.new
  end
end
