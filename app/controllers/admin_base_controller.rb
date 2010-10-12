class AdminBaseController < ApplicationController
#  before_filter :require_admin
  before_filter :authenticate_user!

  def index
  end

  private

  def require_admin
    unless current_user && current_user.admin?
      flash[:error] = 'You must be an admin to do that.'
      redirect_to root_path
    end
  end

end
