require 'stripe'  
class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    # post '/create-checkout-session' do
    current_tenant.processor = :stripe
    Stripe.api_key = ENV['STRIPE_SECRET']
    byebug
    @checkout_session = current_tenant.payment_processor.checkout(
      mode: "subscription",
      line_items: "price_1InP6BHPqdZEH70cIjVqFBjk"
    )
    byebug
  end

end
  