class Api::V1::ProductsController < ApplicationController
  before_action :set_item, only: %i[show update destroy]
  before_action :check_owner_admin, only: %i[update destroy]
  before_action :check_admin_user, only: [:create]

  def index
    products = Product.all
    render json: { products: products }, status: :ok
  end

  def show
    render json: { product: serialized_response(@product) }, status: :ok
  end

  def create
    new_product = current_user.products.build(product_params)
    if new_product.save
      render json: { product: serialized_response(new_product) }, status: :created
    else
      render json:   { errors: new_product.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: serialized_response(@product), status: :ok
    else
      render json:   { errors: @product.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    render json: "#{@product} was deleted successfully"
  end

  private

    def set_item
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :quantity, :price, :image, :type_id, :time_to_make)
    end

    def check_owner_admin
      unless is_admin_user? && current_user.id == @product.user_id
        render json:   { error: 'You dont have permission to modify the product' },
               status: :unauthorized
      end
    end

    def serialized_response(model)
      ProductSerializer.new(model)
    end
end
