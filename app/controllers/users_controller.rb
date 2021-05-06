class UsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_current_account
  def index
  end

  private
  def set_current_account
    @current_account = Account.find_by(id: current_user.current_tenant_id)
  end

end
