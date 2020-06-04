class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index create show]


  def index
    return render json: { message: 'You dont have orders yet' } if current_user.orders.empty?

    render json: current_user.orders
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
    order = Order.create! user: current_user
    order.create_placement(order_params[:product_ids_and_quantities])
    if order.save
      OrderMailer.send_confirmation(order).deliver
      render json: order, status: 201
    else
      render json: { errors: order.errors.full_messages }, status: 422
    end
  end

  private

    def order_params
      params.require(:order).permit(product_ids_and_quantities: [:product_id, :quantity])
    end

end
