# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  # skip_before_action :authenticate_user!
  before_action :configure_permitted_parameters
  prepend_before_action :require_no_authentication, only: [:new, :create]
  #before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource
    resource.build_account
    yield resource if block_given?
    respond_with resource 
  end

  def create
    build_resource
    resource.build_account
    resource.assign_attributes(sign_up_params)
  
    if resource.valid?
      resource.save
      Membership.create(user_id: resource.id, account_id: resource.account.id)
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  protected

    def set_account
      @account = Account.find(params[:id])
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [account_attributes: [:name, :plan, :subdomain, :cc_number]])
    end
 
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [account_attributes: [:name, :password, :subdomain]])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
