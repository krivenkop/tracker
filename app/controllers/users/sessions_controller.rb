# frozen_string_literal: true


class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    unless verify_user_data(user_params)
      render json: { success: false }, status: :forbidden
      return
    end

    jwt_auth = JwtAuth.new(
        secret: Rails.application.credentials.secret_key_base,
        refresh_lifetime: 48.hours,
        access_lifetime: 30.minutes
    )
    render json: jwt_auth.authenticate(@user)
  end

  private

  def verify_user_data(data)
    @user = User.find_by(email: data[:email])
    return false if @user.nil?

    @user&.valid_password?(data[:password])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
