class ProjectsController < ApplicationController
  before_filter :load_new_project, :only => [:new, :create]
  before_filter :load_project, :only => [:show, :edit, :update, :destroy]

  protected
  def load_new_project
    @project = Project.new(params[:project])
  end

  def load_project
    @project = Project.find(params[:id])
  end

  public
  def index
    @projects = Project.all
  end

  def show
  end

  def new
  end

  def create
    if @project.save
      flash[:notice] = "Project created successfully."
      redirect_to @project
    else
      flash.now[:error] = "There was a problem saving the new project."
      render :action => 'new'
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = "Project was destroyed"
    else
      flash[:error] = "There was a problem destroying that project."
    end
    redirect_to projects_path
  end
end
