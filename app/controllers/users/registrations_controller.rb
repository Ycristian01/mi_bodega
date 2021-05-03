# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  # skip_before_action :authenticate_user!
  before_action :sign_up_params, only: [:create]
  before_action :configure_permitted_parameters
  prepend_before_action :require_no_authentication, only: [:new, :create]
  #before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource(sign_up_params)
    resource.build_account
  end

  def create
    build_resource
    resource.build_account 
    Membership.create(user_id: resource.id, account_id: resource.account.id)
    byebug
  end

  protected

    def set_account
      @account = Account.find(params[:id])
    end

    def sign_up_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        account_attributes: [:name, :plan, :subdomain, :cc_number]
      )
    end

    def account_params
      params.permit(:name, :subdomain, :cc_number)
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
