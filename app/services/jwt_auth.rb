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

  # @return [JwtAuth]
  def self.create
    self.new(
        secret: Rails.application.credentials.secret_key_base,
        refresh_lifetime: 48.hours,
        access_lifetime: 30.minutes
    )
  end

  def access_token(payload)
    JWT.encode(
        payload, secret, algorithm,
        { exp: (Time.now + @access_lifetime).to_i }
    )
  end

  def verify_access_token(access_token)
    JWT.decode(access_token, secret, true, { algorithm: algorithm })
  end

  def authenticate(user)
    refresh_token = RefreshToken.create({
      token: SecureRandom.uuid,
      user: user,
      expires_on: Time.now + @refresh_lifetime
    })

    {
        access: access_token({ user: user.as_json }),
        refresh: {
            token: refresh_token.token,
            expires_on: refresh_token.expires_on.to_i
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
