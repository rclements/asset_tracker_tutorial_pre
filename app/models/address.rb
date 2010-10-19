class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true

  validates_presence_of :address1
  validates_presence_of :state
  validates_presence_of :city
  validates_presence_of :zipcode
end

