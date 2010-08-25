class Client < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :status
  validates_uniqueness_of :name
end
