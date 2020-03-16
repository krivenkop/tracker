# frozen_string_literal: true


class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    unless verify_user_data(user_params)
      render json: { success: false }, status: :forbidden
      return
    end

    jwt_auth = JwtAuth.create
    render json: jwt_auth.authenticate(@user)
  end

  def update_access_token
    refresh_token = RefreshToken.find_by(token: refresh_token_params[:refresh_token])

    render json: { success: false }, status: :forbidden and return if refresh_token.nil?
    render json: { success: false }, status: :unauthorized and return if refresh_token.expired?

    jwt_auth = JwtAuth.create
    response = {
        access: jwt_auth.access_token({ user: refresh_token.user.as_json })
    }

    render json: response
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

  def refresh_token_params
    params.permit(:refresh_token)
  end
end
