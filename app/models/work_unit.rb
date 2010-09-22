class WorkUnit < ActiveRecord::Base
  acts_as_commentable
  belongs_to :ticket
  validates_presence_of :ticket_id
  validates_presence_of :description
  validates_presence_of :hours
  validates_presence_of :scheduled_at
end
