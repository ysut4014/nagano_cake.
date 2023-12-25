class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def after_sign_up_path_for(resource)
    customer_path(current_customer) # Assuming you have a 'customer' route
  end  

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:telephone_number, :other_attributes_you_may_have])
  end
end