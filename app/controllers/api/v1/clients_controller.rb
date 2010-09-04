class Api::V1::ClientsController < Api::V1::BaseController
  def index
    @clients = Client.all
    respond_with(@clients, :only => [:name, :status, :guid])
  end
end
