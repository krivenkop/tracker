class ApiController < ActionController::API
  attr_reader :user

  private

  def authorize_jwt
    jwt_auth = JwtAuth.create
    begin
      access_token_data = jwt_auth.verify_access_token(params[:access_token])
    rescue JWT::DecodeError => e
      head :unauthorized and return
    end

    head :unauthorized and return unless access_token_data

    @user = access_token_data[0][:user]
  end
end