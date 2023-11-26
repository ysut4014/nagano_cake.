class Admin::SessionsController < Devise::SessionsController
  # ...

  def create
    super do |resource|
      if resource == :admin
        # 管理者の場合の処理
        redirect_to admin_top_path and return
      elsif resource == :customer
        # 顧客の場合の処理
        redirect_to customer_dashboard_path and return
      end
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