class ClientsController < ApplicationController
  before_filter :load_new_client, :only => [:new, :create]
  before_filter :load_client, :only => [:edit, :show, :update]
  before_filter :load_file_attachments, :only => [:show, :new, :create]
  before_filter :require_admin, :only => [:edit, :new, :create]
  before_filter :require_access, :except => [:index]

  protected
  def load_new_client
    @client = Client.new(params[:client])
  end

  def load_client
    @client = Client.find(params[:id])
  end

  def load_file_attachments
    @file_attachments = @client.file_attachments
  end

  public
  def index
    @clients = Client.all
  end

  def show
    @projects = Project.for_user(current_user).select{|p| p.client == @client}
  end

  def new
  end

  def create
    if @client.save
      flash[:notice] = t(:client_created_successfully)
      redirect_to @client
    else
      flash.now[:error] = t(:client_created_unsuccessfully)
      render :action => 'new'
    end
  end

  def update
    if @client.update_attributes(params[:client])
      flash[:notice] = t(:client_updated_successfully)
      redirect_to @client
    else
      flash.now[:error] = t(:client_updated_unsuccessfully)
      render :action => 'edit'
    end
  end

  def edit
  end

  private

  def require_access
    unless @client.allows_access?(current_user)
      flash[:notice] = "Access denied."
      redirect_to root_path
    end
  end
end
