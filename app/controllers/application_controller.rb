class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  include EventsHelper

  def admin_required 
    if signed_in? && is_admin? # is_admin? actually checks to see if they are an admin or ABOVE (superuser)
      return true
    end
    flash[:warning]='You are not authorized to view this'
    redirect_to root_path
    return false 
  end

  def index
  end

end
