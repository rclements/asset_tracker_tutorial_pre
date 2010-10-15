class Contact < ActiveRecord::Base
  belongs_to :client

  has_one :address, :as => :addressable

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email_address
end

