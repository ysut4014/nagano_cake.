class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
def addresses
  
end  
    def show
        @customer = current_customer
    end

    def edit
    end

    def update
        @customer = current_customer
        if @customer.update(customer_params)
           flash[:success] = "登録情報を変更しました。"
           redirect_to customers_show_path
        else
            render 'edit'
        end
    end
    

def quit
end

def quit_destroy
  current_customer.destroy
  redirect_to root_path, notice: '退会が完了しました。ご利用いただきありがとうございました。'
end
private

def customer_params
  params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
end
end

