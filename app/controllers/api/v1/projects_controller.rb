class Api::V1::ProjectsController < ApiController
  before_action :authorize_jwt
  before_action :authorize_project, only: [:show, :update, :destroy]

  def index
    render json: @user.projects
  end

  def show
    render json: @project
  end

  def create
    @project = Project.create params_project

    if @project.valid?
      render json: @project, status: :created
    else
      render json: { errors: @project.errors.messages }, status: :bad_request
    end
  end

  def update
    @project.update params_project

    if @project.valid?
      render json: @project, status: :ok
    else
      render json: { errors: @project.errors.messages }, status: :bad_request
    end
  end

  def destroy
    @project.destroy

    head :ok
  end

  private

  def param_slug
    params.permit(:slug)
  end

  def params_project
    params.require(:project).permit(
        :title,
        :description,
        :color
    )
  end

  def authorize_project
    head :bad_request and return unless param_slug[:slug]

    projects_slugs = @user.projects.pluck(:slug)
    head :forbidden and return unless projects_slugs.include? param_slug[:slug]

    @project = Project.find_by(slug: param_slug[:slug])
  end
end
