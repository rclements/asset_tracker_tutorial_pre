class WorkUnit < ActiveRecord::Base
  belongs_to :ticket
  validates_presence_of :ticket_id
end
