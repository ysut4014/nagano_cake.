class PublicController < ApplicationController
    before_action :authenticate_customer!
  before_action :authorize_customer, only: [:my_page]

  def my_page
    # マイページのコード
  end

  private

  def authorize_customer
    unless current_customer
      redirect_to new_customer_session_path, alert: 'ログインが必要です。'
    end
  end
end
