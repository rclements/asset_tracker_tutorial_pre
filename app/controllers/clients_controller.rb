class ClientsController < ApplicationController
  before_filter :load_new_client, :only => [:new, :create]
  before_filter :load_client, :only => [:edit, :show, :update]
  before_filter :load_file_attachments, :only => [:show, :new, :create]
  before_filter :require_admin, :only => [:edit, :new, :create]
  before_filter :verify_user_authorization, :except => [:new, :create, :index]

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

  def verify_user_authorization
    unless (@client.projects & current_user.projects).any? || current_user.admin?
      flash[:notice] = 'You do not have access to that client.'
      redirect_to root_path
    end
  end

  public
  def index
    @clients = Client.all
  end

  def show
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

end
