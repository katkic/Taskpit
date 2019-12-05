class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks =
      if params[:sort_expired]
        Task.order(expired_at: :desc)
      else
        Task.order(created_at: :desc)
      end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "タスク「#{@task.name}」を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスク「#{@task.name}」を削除しました"
  end

  def search
    @search_params = task_search_params
    @tasks = Task.search(@search_params)
    render :index
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :expired_at, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_search_params
    params.fetch(:search, {}).permit(:name, :status, :expired_at)
  end
end
