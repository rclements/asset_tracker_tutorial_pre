class Admin::UsersController < ApplicationController
  before_filter :load_user_accounts, :only => [:index]
  before_filter :load_user_account, :only => [:show, :update, :edit]
  before_filter :load_new_user_account, :only => [:new, :create]
  
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def update
    @user.update_attributes(params[:user])
    if @user.save
      flash[:notice] = "Updated successfully"
      redirect_to admin_user_path(@user)
    else
      flash[:error] = "Didn't update."
      redirect_to edit_admin_user_path(@user)
    end
  end

  def edit
  end

  def destroy
  end

private

  def load_user_accounts
    @users = User.all
  end

  def load_user_account
    @user = User.find(params[:id])
  end

  def load_new_user_account
    @user = User.new
  end
end
