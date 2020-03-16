class Users::SessionsController < ApiController
  include ActionController::MimeResponds

  before_action :check_refresh_token, only: [:update_access_token, :destroy]
  before_action :authorize_jwt, only: [:verify_access_token]

  def create
    unless verify_user_data(user_params)
      head :forbidden
      return
    end

    jwt_auth = JwtAuth.create
    render json: jwt_auth.authenticate(@user)
  end

  def update_access_token
    head :unauthorized and return if @refresh_token.expired?

    jwt_auth = JwtAuth.create
    response = {
        access: jwt_auth.access_token({ user: @refresh_token.user.as_json })
    }

    render json: response
  end

  def destroy
    @refresh_token.destroy
    head :ok
  end

  def verify_access_token
    head :ok
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

  def check_refresh_token
    if refresh_token_params[:refresh_token].nil?
      head :forbidden
      return
    end

    @refresh_token = RefreshToken.find_by(token: refresh_token_params[:refresh_token])
    head :forbidden if @refresh_token.nil?
  end
end
