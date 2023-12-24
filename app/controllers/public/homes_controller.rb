class Public::HomesController < ApplicationController
    before_action :authenticate_customer!
 def about
 end
  def top
    @items = Item.all
  end
end
