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

      it 'returns logged in user object', post_login: true do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['payload']['user']['email']).to eq user.email
      end

      it 'returns access and refresh tokens', post_login: true do
        expect(JSON.parse(response.body)['jwt']['refresh']).not_to be_empty
        expect(JSON.parse(response.body)['jwt']['access']).not_to be_empty
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
