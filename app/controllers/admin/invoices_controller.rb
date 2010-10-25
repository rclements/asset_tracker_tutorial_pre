class Admin::InvoicesController < ApplicationController
  before_filter :load_unpaid_work_units, :only => [:index]
  before_filter :load_unpaid_work_units_for_client, :only => [:show]
  before_filter :load_client, :only => [:show]
  #before_filter :load_clients, :only => [:index]

  def index
    # TODO: Make this cleaner
    @clients = @work_units.collect{ |wu| wu.client }.uniq
  end

  def show
    @tickets = @work_units.collect{ |wu| wu.ticket }.uniq
  end

  def update
    params[:work_units].each do |key, value|
      if key =~ /\d+/
        work_unit = WorkUnit.find(key.to_i)
        if work_unit
          value.each do |k, v|
            work_unit.update_attributes(k.to_sym => v)
          end
        end
      end
    end

    redirect_to admin_invoice_path
  end

  private

  def load_unpaid_work_units
    @work_units = WorkUnit.where('invoiced IS NULL OR invoiced = ""')
  end

  def load_unpaid_work_units_for_client
    @work_units = WorkUnit.for_client( Client.find(params[:id])).not_invoiced
  end

  def load_clients
    @clients = Client.all
  end

  def load_client
    @client = Client.find(params[:id])
  end
end
