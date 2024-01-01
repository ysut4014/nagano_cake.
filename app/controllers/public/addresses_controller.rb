class Public::AddressesController < ApplicationController
  def index
    @address = Address.new 
    @addresses = Address.all
  end   
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id

    if @address.save
      redirect_to addresses_path, notice: '住所が正常に作成されました。'
    else
      render :index
    end
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      redirect_to addresses_path, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    address = Address.find(params[:id])
    address.destroy
    flash[:notice] = 'Address deleted successfully.'
    redirect_to addresses_path
  end
  
private

  def address_params
   params.require(:address).permit(:postal_code, :address, :name)
  end  
    
end
