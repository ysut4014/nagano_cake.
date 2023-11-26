class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    # ホーム画面に関するコードを追加
  end
end
