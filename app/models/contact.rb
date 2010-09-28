class Contact < ActiveRecord::Base
  belongs_to :client

  has_one :address, :as => :addressable
end
