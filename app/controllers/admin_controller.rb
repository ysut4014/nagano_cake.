class AdminController < ApplicationController
  before_action :authorize_specific_action, only: [:index]

  def index
    # 顧客一覧のコード
  end

  private

  def authorize_specific_action
  end
end
