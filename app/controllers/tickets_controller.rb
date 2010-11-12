class TicketsController < ApplicationController
  before_filter :load_new_ticket, :only => [:new, :create]
  before_filter :load_ticket, :only => [:show, :edit, :update]
  before_filter :load_file_attachments, :only => [:show, :new, :create]

  protected

  def load_new_ticket
    @ticket = Ticket.new(params[:ticket])
    @ticket.project = Project.find(params[:project_id])
  end

  def load_ticket
    @ticket = Ticket.find(params[:id])
  end

  def load_file_attachments
    @file_attachments = @ticket.file_attachments
  end

  public

  def new
  end

  def show
  end

  def edit
  end

  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = "Ticket updated successfully."
      redirect_to ticket_path(@ticket)
    else
      flash.now[:error] = "There was a problem saving the ticket."
      render :action => 'edit'
    end
  end

  def create
    if @ticket.save
      if request.xhr?
        render :json => "{\"success\": true}", :layout => false, :status => 200 and return
      end
      flash[:notice] = "Ticket created successfully."
      redirect_to ticket_path(@ticket) and return
    else
      if request.xhr?
        render :json => @ticket.errors.full_messages.to_json, :layout => false, :status => 406 and return
      end
      flash.now[:error] = "There was a problem creating the ticket"
      render :action => :new and return
    end
  end

  def edit
  end
end
