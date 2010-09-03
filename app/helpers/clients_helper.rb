module ClientsHelper
  def client_status_select(selected=nil)
    options_for_select(Client.statuses.values, nil)
  end
end
