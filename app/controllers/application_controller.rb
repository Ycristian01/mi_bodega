class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
  before_action :authenticate_user!
  
  def current_member
    @current_member||=current_tenant.members.find_by_user_id(current_user.id)
  end

  def after_accept_path_for(resource)
    accounts_path
  end

  def after_sign_in_path_for(resource)
    accounts_path
  end
  
end
