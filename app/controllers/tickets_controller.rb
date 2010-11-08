class TicketsController < ApplicationController
  before_filter :load_project
  before_filter :load_new_ticket
  before_filter :load_ticket, :only => [:show, :edit, :update]
  before_filter :load_file_attachments, :only => [:show, :new, :create]

  protected
  def load_project
    @project = Project.find_by_id(params[:project_id], :include => [:client])
  end

  def load_new_ticket
    @ticket = Ticket.new(params[:ticket])
    @ticket.project = @project
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
      redirect_to project_ticket_path(@project, @ticket)
    else
      flash.now[:error] = "There was a problem saving the ticket."
      render :action => 'edit'
    end
  end

  def create
    if @ticket.save
      flash[:notice] = "Ticket created successfully."
      redirect_to project_ticket_path(@project, @ticket)
    else
      flash.now[:error] = "There was a problem saving the ticket."
      render :action => 'new'
    end
  end

  def edit
  end
end
