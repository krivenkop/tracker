require 'rails_helper'

RSpec.describe "Api::V1::Projects", type: :request do

  describe "GET /" do
    let(:user) { create :user, :with_projects }
    let(:access_token) do
      jwt = JwtAuth.create
      jwt.access_token({ user: user.as_json })
    end

    before { get api_v1_projects_url, params: { access_token: access_token } }

    it 'returns http success' do
      expect(response).to have_http_status :success
    end

    it 'returns projects by user in json' do
      expect(response).to match_response_schema :projects
    end
  end

  describe "GET /:slug" do
    context 'when user has access to project' do
      let(:user) { create :user, :with_project }
      let(:project) { user.projects.first }
      let(:access_token) do
        jwt = JwtAuth.create
        jwt.access_token({ user: user.as_json })
      end

      before { get api_v1_project_url project.slug, params: { access_token: access_token } }

      it 'returns http success' do
        expect(response).to have_http_status :success
      end

      it 'returns project by slug in json' do
        expect(response).to match_response_schema :project
      end
    end

    context 'when user has not access to project' do
      let(:user) { create :user }
      let(:project) { create :project }
      let(:access_token) do
        jwt = JwtAuth.create
        jwt.access_token({ user: user.as_json })
      end

      before { get "/api/v1/projects/#{project.slug}", params: { access_token: access_token } }

      it 'returns forbidden error' do
        expect(response).to have_http_status :forbidden
      end
    end
  end

  describe 'POST /create' do
    let(:user) { create :user }
    let(:access_token) do
      jwt = JwtAuth.create
      jwt.access_token({ user: user.as_json })
    end

    before { post api_v1_projects_url, params: { project: project_params, access_token: access_token } }

    context 'when project params is valid' do
      let(:project_params) { attributes_for :project }

      it 'should return 201 status code' do
        expect(response).to have_http_status :created
      end

      it 'should return new valid project in json' do
        expect(response).to match_response_schema :project
      end
    end

    context 'when project params is not valid' do
      let(:project_params) { attributes_for :project, :empty_attributes }

      it 'should return 400 status code' do
        expect(response).to have_http_status :bad_request
      end

      it 'should return validation errors' do
        expect(json_response[:errors][:title]).not_to be_empty
        expect(json_response[:errors][:color]).not_to be_empty
      end
    end
  end

  describe 'PATCH|PUT /update' do
    let(:user) { create :user, :with_project }
    let(:access_token) do
      jwt = JwtAuth.create
      jwt.access_token({ user: user.as_json })
    end

    before do
      patch api_v1_project_url(user.projects.first.slug),
            params: {
                project: project_params,
                access_token: access_token
            }
    end

    context 'when project params is valid' do
      let(:project_params) { attributes_for :project }

      it 'should return 200 status code' do
        expect(response).to have_http_status :ok
      end

      it 'should return new valid project in json' do
        expect(response).to match_response_schema :project
      end
    end

    context 'when project params is not valid' do
      let(:project_params) { attributes_for :project, :empty_attributes }

      it 'should return 400 status code' do
        expect(response).to have_http_status :bad_request
      end

      it 'should return validation errors' do
        expect(json_response[:errors][:title]).not_to be_empty
        expect(json_response[:errors][:color]).not_to be_empty
      end
    end
  end

  describe 'GET /destroy' do
    let(:user) { create :user, :with_project }
    let(:access_token) do
      jwt = JwtAuth.create
      jwt.access_token({ user: user.as_json })
    end

    before { delete api_v1_project_url(user.projects.first.slug), params: { access_token: access_token } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

end
