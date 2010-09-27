class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_client
  before_filter :load_new_project, :only => [:new, :create]
  before_filter :load_project, :only => [:show, :edit, :update, :destroy]

  protected
  def load_client
    @client = Client.find(params[:client_id])
  end

  def load_new_project
    @project = Project.new(params[:project])
    @project.client = @client
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

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project updated successfully."
      redirect_to [@client, @project]
    else
      flash.now[:error] = "There was a problem saving the project."
      render :action => 'edit'
    end
  end

  def create
    if @project.save
      flash[:notice] = "Project created successfully."
      redirect_to [@client, @project]
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
    redirect_to client_projects_path(@client)
  end
end
