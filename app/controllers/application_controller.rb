class ApplicationController < ActionController::Base
  include RefurlHelper
  before_filter :authenticate_user!
  protect_from_forgery
  layout 'application'
  helper_method :redirect_to_ref_url, :admin?
  
  private
  
  def redirect_unless_monday(path_prefix, date)
    @start_date = date ? Date.parse(date) : Date.today
    unless @start_date.monday?
      redirect_to(path_prefix + @start_date.beginning_of_week.strftime("%F"))
    end
  end

  def admin?
    current_user && current_user.admin?
  end
  
end
