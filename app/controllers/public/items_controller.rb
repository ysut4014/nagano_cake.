class Public::ItemsController < ApplicationController
 def about
 end
  def index
    @items = Item.all # Fetch all items or apply any necessary conditions
  end
end
