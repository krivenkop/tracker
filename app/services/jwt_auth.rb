require 'securerandom'
require 'jwt'

class JwtAuth
  attr_reader :algorithm

  def initialize(config = {})
    @secret = get_config_param(config, :secret, 'Secret key')
    @refresh_lifetime = get_config_param(
        config,
        :refresh_lifetime,
        'Refresh token lifetime'
    )
    @access_lifetime = get_config_param(
        config,
        :access_lifetime,
        'Access token lifetime'
    )

    @algorithm = 'HS256'
  end

  def access_token(payload)
    JWT.encode payload, secret, algorithm
  end

  def authenticate(user)
    refresh_token = RefreshToken.create({
      token: SecureRandom.uuid,
      user: user,
      expires_on: Time.now + @refresh_lifetime
    })

    {
        access: {
            token: access_token(user),
            expires_on: Time.now + @access_lifetime
        },
        refresh: {
            token: refresh_token.token,
            expires_on: refresh_token.expires_on
        }
    }
  end

  private
  attr_reader :secret
  attr_writer :algorithm

  def get_config_param(config, param, param_name)
    if config[param].nil?
      raise "#{param_name.capitalize} cannot nil"
    end

    config[param]
  end
end
