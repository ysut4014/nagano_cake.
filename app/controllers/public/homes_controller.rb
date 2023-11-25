class Public::HomesController < ApplicationController
    before_action :authenticate_customer!

end
