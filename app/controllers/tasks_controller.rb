class TasksController < ApplicationController

  before_action :find_project, except: [:assign]

  def assign
    @task = Task.find(params[:id])
    @task.update_column(:assignee_id, current_user.id)
    redirect_to project_tasks_path(@task.project)
  end

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
