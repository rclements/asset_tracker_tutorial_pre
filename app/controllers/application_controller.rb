class ApplicationController < ActionController::Base
  include RefurlHelper
  before_filter :authenticate_user!
  protect_from_forgery
  layout 'application'
  helper_method :redirect_to_ref_url
end
