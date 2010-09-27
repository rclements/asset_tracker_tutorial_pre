class WorkUnit < ActiveRecord::Base
  include GuidReferenced
  belongs_to :ticket
  belongs_to :user
  validates_presence_of :ticket_id
  validates_presence_of :user_id
  validates_presence_of :description
  validates_presence_of :hours
  validates_presence_of :scheduled_at

  scope :scheduled_between, lambda{|start_date, end_date| where('scheduled_at BETWEEN ? AND ?', start_date, end_date) }
end
