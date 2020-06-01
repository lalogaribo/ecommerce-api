class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:update, :show, :destroy]

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update

  end

  def show

  end

  def destroy

  end

  private

    def user_params
      params.permit(:user).require(:first_name, :last_name, :email,
                                   :phone_number, :address, :zip_code, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end
end