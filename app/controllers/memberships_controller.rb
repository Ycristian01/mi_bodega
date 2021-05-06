class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :set_tenant
  before_action :set_current_account

  def index
    @members = @current_account.memberships.includes(:user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(user_params[:email])
    if @user.nil?
      @user = User.new(user_params.merge(password: "secret"))
      if @user.save 
        @member = @user.memberships.create(account_id: current_user.current_tenant_id)
        @user.invite!(current_user)
        flash[:notice] =  "Email invitation sent to #{@user.email}." 
        redirect_to memberships_path
      else
        render :new
      end
    else
      if !@current_account.memberships.find_by(user_id: @user.id)
        @member = @user.memberships.create(account_id: current_user.current_tenant_id)
        flash[:notice] = "#{@user.email} added succesfully to this account"
        redirect_to memberships_path
      else
        flash.now[:alert] = "#{@user.email} is a member already"
        render :new
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @member = Member.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end

  def set_tenant
    account = Account.find(current_user&.current_tenant_id)
    set_current_tenant(account)
  rescue
    redirect_to accounts_path
  end

  def set_current_account
    @current_account = Account.find_by(id: current_user.current_tenant_id)
  end
end
