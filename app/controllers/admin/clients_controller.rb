class Admin::ClientsController < ApplicationController
  def edit
    @client = Client.find(params[:id])
  end

end
