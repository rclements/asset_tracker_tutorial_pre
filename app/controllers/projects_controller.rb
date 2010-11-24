class ProjectsController < ApplicationController
  before_filter :load_new_project, :only => [:new, :create]
  before_filter :load_project, :only => [:show, :edit, :update]
  before_filter :load_file_attachments, :only => [:show, :new, :create]
  before_filter :verify_user_authorization, :except => [:new, :create]

  protected
  def load_new_project
    @project = Project.new(params[:project])
    @project.client = Client.find(params[:client])
  end

  def load_project
    @project = Project.find(params[:id])
  end

  def load_file_attachments
    @file_attachments = @project.file_attachments
  end

  def verify_user_authorization
    unless current_user.projects.include?(@project) || current_user.admin?
      flash[:notice] = 'You do not have access to that project.'
      redirect_to root_path
    end
  end

  public

  def show
  end

  def new
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project updated successfully."
      redirect_to [@project]
    else
      flash.now[:error] = "There was a problem saving the project."
      render :action => 'edit'
    end
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

end
