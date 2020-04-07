class Api::V1::TasksController < ApiController
  before_action :authorize_jwt
  before_action :authorize_project
  before_action :authorize_task, only: [:show, :update, :destroy]

  def index
    render json: @project.tasks
  end

  def show
    render json: @task
  end

  def create
    @task = @project.tasks.create params_task

    if @task.valid?
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.messages }, status: :bad_request
    end
  end

  def update
    @task.update params_task

    if @task.valid?
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors.messages }, status: :bad_request
    end
  end

  def destroy
    @task.destroy

    head :ok
  end

  private

  def params_slug
    params.permit(:slug, :project_slug)
  end

  def params_task
    params.require(:task).permit(
        :title,
        :description,
        :end_date,
        :status,
        :priority
    )
  end

  def authorize_project
    head :bad_request and return unless params_slug[:project_slug]

    projects_slugs = @user.projects.pluck(:slug)
    head :forbidden and return unless projects_slugs.include? params_slug[:project_slug]

    @project = Project.find_by(slug: params_slug[:project_slug])
  end

  def authorize_task
    head :bad_request and return unless params_slug[:slug]

    tasks_slugs = @project.tasks.pluck(:slug)
    head :forbidden and return unless tasks_slugs.include? params_slug[:slug]

    @task = Task.find_by(slug: params_slug[:slug])
  end
end
