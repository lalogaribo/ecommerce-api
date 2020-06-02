module Authenticable
  def current_user
    return @current_user if @current_user

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)
    @current_user = User.find(decoded[:user_id]) rescue ActiveRecord::RecordNotFound
  end

  def is_admin_user?
    @current_user.is_admin
  end

  def check_admin_user
    render json: { error: 'Only admin user can perform this action' }, status: :unauthorized unless current_user && is_admin_user?
  end
end