class ContactsController < ApplicationController
  before_filter :load_client, :only => [:index, :edit, :show, :update]
  before_filter :load_contact, :only => [:edit, :show, :update, :destroy]
  before_filter :require_admin, :only => [:destroy]

  protected
  def load_client
    @client = Client.find(params[:id])
  end

  def load_contact
    @contact = Contact.find(params[:id])
  end

  public
  def index
    @contact = @client.contact.all
  end

  def show
  end

  def new
  end

  def create
    if @contact.save
      flash[:notice] = "Client created successfully."
      redirect_to @contact
    else
      flash.now[:error] = "There was a problem saving the new contact."
      render :action => 'new'
    end
  end

  def update
    @contact = Client.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:notice] = "Client updated successfully."
      redirect_to @contact
    else
      flash.now[:error] = "There was a problem saving the contact."
      render :action => 'edit'
    end
  end

  def edit
  end

  def destroy
    @contact = Contact.find(params[:id])
    if @contact.destroy
      flash[:notice] = "Client was successfully deleted"
      redirect_to client_contacts_path
    else
      flash.now[:error] = "There was a problem deleting the contact."
      render :action => 'show'
    end
  end

end
