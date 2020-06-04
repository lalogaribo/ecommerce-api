class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index create show]

  def index
    render json: OrderSerializer.new(current_user.orders)
  end

  private

    def order_params
      params.require(:order).permit(:total, product_ids: [])
    end
end
