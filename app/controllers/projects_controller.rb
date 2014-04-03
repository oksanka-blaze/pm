class ProjectsController < ApplicationController

  load_and_authorize_resource param_method: :project_params

  def index
    @projects = Project.includes(:owner)
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private
    
    def project_params
      params.require(:project).permit(:name)
    end
end
