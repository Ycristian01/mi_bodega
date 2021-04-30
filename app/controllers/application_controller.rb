class ApplicationController < ActionController::Base
  set_current_tenant_by_subdomain(:account,:subdomain)

  # before_action do
  #   binding.irb
  # end
end
