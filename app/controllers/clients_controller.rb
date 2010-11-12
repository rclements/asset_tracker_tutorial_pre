class ClientsController < ApplicationController
  before_filter :load_new_client, :only => [:new, :create]
  before_filter :load_client, :only => [:edit, :show, :update]
  before_filter :load_file_attachments, :only => [:show, :new, :create]
  before_filter :require_admin, :only => [:edit, :new, :create]

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
  end

  def new
  end

  def create
    if @client.save
      flash[:notice] = "Client created successfully."
      redirect_to @client
    else
      flash.now[:error] = "There was a problem saving the new client."
      render :action => 'new'
    end
  end

  def update
    if @client.update_attributes(params[:client])
      flash[:notice] = "Client updated successfully."
      redirect_to @client
    else
      flash.now[:error] = "There was a problem saving the client."
      render :action => 'edit'
    end
  end

  def edit
  end

end
