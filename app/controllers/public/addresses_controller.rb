class Public::AddressesController < ApplicationController
    before_action :set_customer

    def index
            @addresses = current_customer.addresses

    end

    private

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end
      
end
