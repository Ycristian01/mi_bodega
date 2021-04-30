class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  set_current_tenant_by_subdomain(:account,:subdomain)
  helper_method :change_subdomain

  def change_subdomain(url, old_subdomain, new_subdomain)
    if old_subdomain == ""
      if new_subdomain == ""
        url.gsub("//#{old_subdomain}","//#{new_subdomain}")
      else
        url.gsub("//#{old_subdomain}","//#{new_subdomain}.")
      end
    else
      if new_subdomain == ""
        url.gsub("//#{old_subdomain}.","//#{new_subdomain}")
      else
        url.gsub("//#{old_subdomain}","//#{new_subdomain}")
      end
    end
  
  end

  def after_sign_out_path_for(resource_or_scope)
    subdomain = request.subdomain
    url = request.protocol + request.host_with_port
    change_subdomain(url, subdomain, "")
  end
end
