require 'stripe'

class Account < ApplicationRecord
  include Pay::Billable
  belongs_to :user

  validates :name, presence: true
  validates :name, format: { with:  /\A[A-Za-z0-9\-\s]*\z/ }
  validates :plan, presence: true

  has_many :boxes, dependent: :destroy
  has_many :memberships, dependent: :destroy

  before_save -> do
    self.card_last4 = self.card_number[-4..-1]
  end

  PRICES = { moderate: 100, unlimited: 500 }

  def self.prices 
    PRICES
  end

  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1] }
  end

  def self.year_options
    (Date.today.year..(Date.today.year+10)).to_a
  end

  Plans = [:free, :moderate, :unlimited]
  STRIPE_PRICES = { moderate: "price_1InTzQHPqdZEH70cmJiVyzv6", unlimited: "price_1InU00HPqdZEH70c48pJpYXP" }

  def update_card(account_params)
    Stripe.api_key = ENV['STRIPE_SECRET']
    price = STRIPE_PRICES[plan.to_sym]
    card_hash = {number: account_params[:card_number], exp_month: account_params[:card_exp_month], exp_year: account_params[:card_exp_year], 
      last4: account_params[:card_number][-4..-1], cvc: account_params[:cvc]}

    token = Stripe::Token::create({card: card_hash})[:id]
    customer = Stripe::Customer.update user.account.stripe_customer_id, source: token
    card = Stripe::Customer.list_sources(customer[:id])[:data].first
      
    self.stripe_id = card[:id]
  end
  
  def subscription()
    Stripe.api_key = ENV['STRIPE_SECRET']
    price = STRIPE_PRICES[plan.to_sym]
    card_hash = {number: user.account.card_number, exp_month: user.account.card_exp_month, 
      exp_year: user.account.card_exp_year, last4: user.account.card_last4, cvc: user.account.cvc}
    token = Stripe::Token::create({card: card_hash})[:id]
    customer = Stripe::Customer.create email: user.email, source: token
    card = Stripe::Customer.list_sources(customer[:id])[:data].first

    self.stripe_id =  card[:id]
    self.stripe_customer_id =  card[:customer]
    self.card_type = card[:brand]
    Stripe::PaymentMethod.create({type: 'card',
                    card: {
                    number: card_hash[:number],
                    cvc: card_hash[:cvc],
                    exp_month: card_hash[:exp_month], 
                    exp_year: card_hash[:exp_year], 
                    last4: card_hash[:card_last4],
                      },
                    })
  
    update(stripe_customer_id: customer[:id])
    Stripe::Subscription.create({
      customer: customer[:id],
      items: [
        {price: price},
      ],
    })
  end

end
