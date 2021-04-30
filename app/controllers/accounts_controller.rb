class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]
  
  def index
    @accounts = Account.all
  end

  def show

  end

  def new
    @account = current_user.accounts.new
  end

  def create 
    @account = current_user.accounts.create(account_params)
    if @account.save
      redirect_to users_path
      @membership = Membership.new(user_id: current_user.id, account_id: @account.id)
      @membership.save
      flash[:notice] = "account created successfully"

    else
      render 'users#index'
    end
  end

  private

    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name, :email, :password, :cc_number)
    end
end
