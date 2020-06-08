class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(login_params[:email])
    if user&.authenticate(login_params[:password])
      render json: {
        data: {
          user:  user,
          token: JsonWebToken.encode(user_id: user.id)
        }
      }
    else
      head :unauthorized
    end
  end

  private

    def login_params
      params.require(:user).permit(:email, :password)
    end
end
