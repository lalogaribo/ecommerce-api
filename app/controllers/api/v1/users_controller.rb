class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy, :show]
  before_action :check_owner, only: [:update, :destroy, :show]

  def create
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @user, status: :ok
  end

  def destroy
    @user.destroy
    head 204
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :phone_number, :address, :zip_code, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def check_owner
      head :forbidden unless @user.id == current_user&.id
    end
end