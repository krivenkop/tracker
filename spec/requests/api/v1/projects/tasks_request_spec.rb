require 'rails_helper'

RSpec.describe "Api::V1::Tasks", type: :request do

  describe "GET /" do
    let(:user) { create :user, :with_project_and_tasks }
    let(:project) { user.projects.first }
    let(:access_token) do
      jwt = JwtAuth.create
      jwt.access_token({user: user.as_json})
    end

    before do
      get api_v1_project_tasks_url(user.projects.first.slug), params: {access_token: access_token}
    end

    it 'returns http success' do
      expect(response).to have_http_status :success
    end

    it 'returns tasks by user in json' do
      expect(response).to match_response_schema :tasks
    end
  end

  describe "GET /:slug" do
    context 'when task is related to project' do
      before do
        get(
            api_v1_project_task_url(project.slug, task.slug),
            params: {access_token: access_token}
        )
      end

      context 'when user has access to project' do
        let(:user) { create :user, :with_project_and_task }
        let(:project) { user.projects.first }
        let(:task) { project.tasks.first }
        let(:access_token) do
          jwt = JwtAuth.create
          jwt.access_token({user: user.as_json})
        end

        it 'returns http success' do
          expect(response).to have_http_status :success
        end

        it 'returns task by slug in json' do
          expect(response).to match_response_schema :task
        end
      end

      context 'when user has not access to project' do
        let(:user) { create :user }
        let(:project) { create :project, :with_task }
        let(:task) { project.tasks.first }
        let(:access_token) do
          jwt = JwtAuth.create
          jwt.access_token({user: user.as_json})
        end

        it 'returns forbidden error' do
          expect(response).to have_http_status :forbidden
        end
      end
    end

    context 'when task is not related to project' do
      let(:user) { create :user }
      let(:project) { create :project, :with_task }
      let(:task) { project.tasks.first }
      let(:access_token) do
        jwt = JwtAuth.create
        jwt.access_token({user: user.as_json})
      end

      before do
        get(
            api_v1_project_task_url(project.slug, task.slug),
            params: {access_token: access_token}
        )
      end

      context 'when user has access to project' do
        let(:another_project) { user.projects.create attributes_for :project  }

        it 'returns forbidden error' do
          expect(response).to have_http_status :forbidden
        end
      end
    end
  end

  describe 'POST /create' do
    let(:user) { create :user, :with_project }
    let(:project) { user.projects.first }
    let(:access_token) do
      jwt = JwtAuth.create
      jwt.access_token({user: user.as_json})
    end

    before do
      post(
          api_v1_project_tasks_url(project.slug),
          params: {task: task_params, access_token: access_token}
      )
    end

    context 'when task params is valid' do
      let(:user) { create :user, :with_project }
      let(:project) { user.projects.first }
      let(:task_params) { attributes_for :task }

      it 'should return 201 status code' do
        expect(response).to have_http_status :created
      end

      it 'should return new valid task in json' do
        expect(response).to match_response_schema :project
      end
    end

    context 'when task params is not valid' do
      let(:task_params) { attributes_for :task, :empty_attributes }

      it 'should return 400 status code' do
        expect(response).to have_http_status :bad_request
      end

      it 'should return validation errors' do
        expect(json_response[:errors][:title]).not_to be_empty
      end
    end
  end

  describe 'PATCH|PUT /:slug' do
    let(:user) { create :user, :with_project_and_task }
    let(:project) { user.projects.first }
    let(:task) { project.tasks.first }
    let(:access_token) do
      jwt = JwtAuth.create
      jwt.access_token({user: user.as_json})
    end

    before do
      patch(
          api_v1_project_task_url(project.slug, task.slug),
          params: {
              task: task_params,
              access_token: access_token
          }
      )
    end

    context 'when task params is valid' do
      let(:task_params) { attributes_for :task }

      it 'should return 200 status code' do
        expect(response).to have_http_status :ok
      end

      it 'should return new valid project in json' do
        expect(response).to match_response_schema :task
      end
    end

    context 'when task params is not valid' do
      let(:task_params) { attributes_for :task, :empty_attributes }

      it 'should return 400 status code' do
        expect(response).to have_http_status :bad_request
      end

      it 'should return validation errors' do
        expect(json_response[:errors][:title]).not_to be_empty
      end
    end
  end

  describe 'GET /destroy' do
    let(:user) { create :user, :with_project_and_task }
    let(:project) { user.projects.first }
    let(:task) { project.tasks.first }

    let(:access_token) do
      jwt = JwtAuth.create
      jwt.access_token({ user: user.as_json })
    end

    before do
      delete(api_v1_project_task_url(project.slug, task.slug), params: { access_token: access_token })
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
  end

end
