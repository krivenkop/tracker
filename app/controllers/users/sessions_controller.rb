# frozen_string_literal: true


class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    unless authenticate(user_params)
      render json: { success: false }, status: :forbidden
      return
    end

    jwt_auth = JwtAuth.new(
        secret: Rails.application.credentials.secret_key_base,
        refresh_lifetime: 48.hours,
        access_lifetime: 30.minutes
    )
    tokens = jwt_auth.authenticate(@user)

    response = {
        jwt: {
            access: tokens[:access],
            refresh: tokens[:refresh]
        },
        payload: { user: @user }
    }

    render json: response
  end

  private

  def authenticate(data)
    @user = User.find_by(email: data[:email])
    return false if @user.nil?

    @user&.valid_password?(data[:password])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
