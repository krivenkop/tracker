require 'rails_helper'

RSpec.describe JwtAuth do
  let(:refresh_lifetime) { 48.hours }
  let(:access_lifetime) { 30.minutes }
  let(:secret) { Rails.application.credentials.secret_key_base }

  RSpec.configure do |config|
    config.before(:each, :create_jwt_auth => true) do
      @jwt_auth = JwtAuth.new(
          secret: secret,
          refresh_lifetime: refresh_lifetime,
          access_lifetime: access_lifetime
      )
    end
  end

  context '#initialize' do
    it 'should throw error on nil secret key' do
      scenario = -> { JwtAuth.new(refresh_lifetime: 16.hours, access_lifetime: 1.hour) }
      expect(scenario).to raise_error(ArgumentError)
    end

    it 'should throw error on nil refresh lifetime' do
      scenario = -> { JwtAuth.new(
          secret: secret,
          access_lifetime: 1.hour
      ) }
      expect(scenario).to raise_error(ArgumentError)
    end

    it 'should throw error on nil access lifetime' do
      scenario = -> { JwtAuth.new(
          secret: Rails.application.credentials.secret_key_base,
          refresh_lifetime_lifetime: 1.hour
      ) }
      expect(scenario).to raise_error(ArgumentError)
    end
  end

  context '#create' do
    it 'should return new valid class object', create_jwt_auth: true do
      expect(JwtAuth.create.to_json).to eq @jwt_auth.to_json
    end
  end

  context 'instance methods' do
    let(:payload) { { data: [] } }

    context '.access_token', create_jwt_auth: true do
      it 'should return valid jwt token' do
        encoded = JWT.encode(
            payload, secret, @jwt_auth.algorithm,
            { exp: (Time.now + access_lifetime).to_i }
        )

        expect(@jwt_auth.access_token(payload)).to eq encoded
      end
    end

    context '.verify_access_token', create_jwt_auth: true do
      it 'should return decoded data on valid token' do
        decoded = JWT.decode(
          @jwt_auth.access_token(payload), secret, true,
          { algorithm: @jwt_auth.algorithm }
        )

        expect(decoded).to be_a Array
        expect(decoded[0]).to eq payload.stringify_keys
        expect(decoded[1]["exp"]).to be_a Integer
        expect(decoded[1]["alg"]).to eq @jwt_auth.algorithm
      end
    end

    context '.authenticate', create_jwt_auth: true do
      let(:user) { create :user }

      it 'should create new RefreshToken object' do
        refresh_tokens_count = RefreshToken.count

        @jwt_auth.authenticate user

        expect(RefreshToken.count).to eq(refresh_tokens_count + 1)
      end

      it 'should return hash with tokens' do
        tokens = @jwt_auth.authenticate user

        expect(tokens[:access]).to eq @jwt_auth.access_token({ user: user.as_json })
        expect(tokens[:refresh][:token]).to be_a String
        expect(tokens[:refresh][:expires_on]).to eq((Time.now + refresh_lifetime).to_i)
      end
    end
  end
end