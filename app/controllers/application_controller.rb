class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_root_path
    when Customer
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number])
  end
  
  def public_page?
    # Add logic here to determine if the current page is public
    # For example, check if the controller is in the "public" namespace
    params[:controller].start_with?('public/')
  end  
  
end