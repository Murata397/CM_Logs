class ApplicationController < ActionController::Base
  before_action :configure_authentication
 
  private
 
  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      if !action_is_public?
        authenticate_user!
      end
    end
  end
 
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end
 
  def action_is_public?
    controller_name == 'homes' && action_name == 'top'
  end
end
