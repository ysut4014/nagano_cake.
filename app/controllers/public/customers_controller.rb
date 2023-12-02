class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
def addresses
  # アクションの中身
end    # マイページへのアクション
    def show
        @customer = current_customer
    end

    # 登録情報編集へのアクション
    def edit
    end

    # 登録情報の編集を保存するアクション
    def update
        @customer = current_customer
        if @customer.update(customer_params)
           flash[:success] = "登録情報を変更しました。"
           redirect_to customers_show_path
        else
            render 'edit'
        end
    end
    

    # 登録情報編集画面から退会ページを表示するアクション
def quit
  # 退会ページに初めてアクセスした時の処理
end

def quit_destroy
  current_customer.destroy
  # その他の処理（例: サインアウトなど）
  redirect_to root_path, notice: '退会が完了しました。ご利用いただきありがとうございました。'
end
private

def customer_params
  params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
end
end

