class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]
  
  def index
    @accounts = current_user.accounts
  end

  def new
    @account = current_user.accounts.new
  end

  def create 
    current_user.accounts.create(account_params)
    flash[:notice] = "Contacts uploaded successfully"
    redirect_to accounts_path
  end

  private

    def set_account
      @account = current_user.contacts.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:name, :email, :password, :cc_number)
    end
end
