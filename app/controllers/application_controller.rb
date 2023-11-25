class ApplicationController < ActionController::Base
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  def after_sign_in_path_for(resource)
    if resource == :admin
        
    elsif rosource == :customer
        
    end
  end
      
end