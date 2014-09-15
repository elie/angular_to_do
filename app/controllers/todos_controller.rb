class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]
  # create a before_action that just returns the template
  #   without the layout
  before_action :render_main_layout_if_format_html

  respond_to :json, :html

  def index
    respond_with (@todos = Todo.all)
  end

  def create
    respond_with Todo.create(todo_params)
  end

  def show
    respond_with @todo
  end

  def update
    respond_with @todo.update(todo_params)
  end

  def destroy
    respond_with @todo.destroy
  end

  private
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:thing, :completed)
  end

  def render_main_layout_if_format_html
    # check the request format
    if request.format.symbol == :html
      render "layouts/application"
    end
  end

end