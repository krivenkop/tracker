require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do

  describe 'POST /login' do
    let(:user) { create :user }

    context 'params is valid' do
      RSpec.configure do |config|
        config.before(:each, :post_login => true) do
          post user_session_url, params: { user: { email: user.email, password: user.password } }
        end
      end

      it 'saves new refresh token to database' do
        tokens_count = RefreshToken.count

        post user_session_url, params: { user: { email: user.email, password: user.password } }

        expect(RefreshToken.count).to eq tokens_count + 1
      end

      it 'returns right jwt access token', post_login: true do
        jwt_auth = JwtAuth.create
        valid_access_token = jwt_auth.access_token({ user: user.as_json })

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['access']).to eq valid_access_token
      end

      it 'returns access and refresh tokens', post_login: true do
        expect(JSON.parse(response.body)['refresh']).not_to be_empty
        expect(JSON.parse(response.body)['access']).not_to be_empty
      end
    end

    context 'params is invalid' do
      let(:user) { create :user }
      let(:another_user_params) { attributes_for :user }
      before do
        user.save
        post user_session_url, params: { user: another_user_params }
      end

      it 'returns forbidden error' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST /update-access-token' do
    let(:user) { create :user }

    context 'refresh token is valid' do
      context 'refresh token is not expired' do
        let(:refresh_token) { create :refresh_token }
        before { post update_access_token_url, params: { refresh_token: refresh_token.token } }

        it 'should return new valid access token' do
          jwt_auth = JwtAuth.create
          valid_access_token = jwt_auth.access_token({ user: refresh_token.user.as_json })

          expect(JSON.parse(response.body)['access']).to eq valid_access_token
        end
      end

      context 'refresh token is expired' do
        let(:refresh_token) { create :refresh_token, :skips_validations, :expires_on_now }
        before { post update_access_token_url, params: { refresh_token: refresh_token.token } }

        it 'should return unauthorized error' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    context 'refresh token is invalid' do
      before { post update_access_token_url, params: { refresh_token: 'invalid_refresh_token' } }

      it 'should return forbidden error' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

end