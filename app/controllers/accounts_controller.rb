class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: %i[ show edit update destroy billing]
  before_action :set_current_account

  def index
    @accounts = current_user.accounts
    @memberships = current_user.memberships
  end

  def show
    @boxes = @account.boxes.all
  end

  def billing
    Stripe.api_key = ENV['STRIPE_SECRET']

    @charges = Stripe::Charge.list({customer: @current_account.stripe_customer_id})[:data]
    @subscription = Stripe::Subscription.list({customer: @current_account.stripe_customer_id, limit: 1})[:data].first
    
  end

  def select 
    current_user.update(current_tenant_id: params[:id])
    redirect_to boxes_path
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
      params.require(:account).permit(:name, :subdomain, :plan, :card_number, :card_expires, :cvc, :card_exp_month, :card_exp_year)
    end

    def set_current_account
      @current_account = Account.find_by(id: current_user.current_tenant_id)
    end
    
end
