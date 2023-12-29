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

    # 退会アクション
    def withdraw
        @customer = current_customer
        
        # is_customer_statusカラムにフラグを立てる(default→false(有効状態)をtrue(無効状態)にする）
        @customer.update(is_active: false)
        # ログアウトさせる
        reset_session

        flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
        redirect_to root_path
    end



private

def customer_params
  params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
end
end

