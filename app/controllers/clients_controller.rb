class ClientsController < ApplicationController
  before_filter :load_new_client, :only => [:new, :create]
  before_filter :load_client, :only => [:show, :edit, :update, :destroy]

  protected
  def load_new_client
    @client = Client.new(params[:client])
  end

  def load_client
    @client = Client.find(params[:id])
  end

  public
  def index
    if params[:term]
      @clients = Client.find(:all, :conditions => ["name like ?", '%' + params[:term] + '%'])
    else
      @clients = Client.all
    end
  end

  def show
  end

  def edit
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

  def destroy
    if @client.destroy
      flash[:notice] = "Client was destroyed"
    else
      flash[:error] = "There was a problem destroying that client."
    end
    redirect_to clients_path
  end
end
