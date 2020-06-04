class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index create show]


  def index
    return render json: { message: 'You dont have orders yet' } if current_user.orders.empty?

    render json: OrderSerializer.new(current_user.orders)
  end

  def show
    order = current_user.orders.find(params[:id])

    if order
      render json: order, status: :ok
    else
      render json: { errors: 'Order not found' }, status: :not_found
    end
  end

  def create
    order = current_user.orders.build(order_params)
    if order.save
      render json: order, status: 201
    else
      render json: { errors: order.errors }, status: 422
    end
  end

  private

    def order_params
      params.require(:order).permit(:total, product_ids: [])
    end

end
