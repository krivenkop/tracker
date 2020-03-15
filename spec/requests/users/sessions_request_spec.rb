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
        jwt_auth = JwtAuth.new(
            secret: Rails.application.credentials.secret_key_base,
            refresh_lifetime: 48.hours,
            access_lifetime: 30.minutes
        )
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

      it 'returns unauthorized error' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

end
