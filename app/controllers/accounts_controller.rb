class AccountsController < ApplicationController
  #before_action :set_account, only: %i[ show edit update destroy ]
  
  def index
    @accounts = current_user.accounts
  end

  def new
    @account = current_user.accounts.new
  end

  def create 
    @account = current_user.accounts.create(account_params)
    
    if @account.save
      redirect_to users_path
      flash[:notice] = "account created successfully"
    else
      render 'users#index'
    end
  end

  private

    def set_account
      @account = current_user.contacts.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name, :email, :password, :cc_number)
    end
end
