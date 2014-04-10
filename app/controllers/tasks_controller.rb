class TasksController < ApplicationController

  before_action :find_project

  def index
    @tasks = @project.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_tasks_path(@project)
    else
      render :new
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :assignee_id, :due_date)
  end

end
