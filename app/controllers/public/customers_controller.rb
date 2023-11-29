class Public::CustomersController < ApplicationController
  def index
    # Your index action logic
  end


  def new
    @customer = Customer.new
  end
def create
  @customer = Customer.new(customer_params)
  if @customer.save
    redirect_to customer_path(@customer), notice: '新規登録が成功しました！'
  else
    puts @customer.errors.full_messages # ターミナルにエラーメッセージを出力
    render :new
  end
end

  def show
    @customer = Customer.find(params[:id])
    # 他のshowアクションのロジックを追加することができます
  end

private

def customer_params
  params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password, :password_confirmation)
end
end

