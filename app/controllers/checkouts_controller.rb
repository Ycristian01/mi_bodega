class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    current_tenant.processor = :stripe

    @checkout_session = current_tenant.payment_processor.checkout(
      mode: "payment",
      line_items: "price_1InCleHPqdZEH70cQPaF8QLI"
    )
  end

end
  