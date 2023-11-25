class Admin::SessionsController < Devise::SessionsController
  # ...

  def create
    if resource == :admin
    elsif resource == :customer
    end
  end
  
  private

  def after_sign_in_path_for(resource)
    admin_top_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end
end