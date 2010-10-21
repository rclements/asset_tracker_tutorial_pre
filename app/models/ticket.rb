class Ticket < ActiveRecord::Base
  include GuidReferenced
  acts_as_commentable
  belongs_to :project
  has_many :work_units

  validates_presence_of :project_id
  validates_presence_of :name

  def client
    project.client
  end

  def to_s
    name
  end

  def sum_of_hours_unpaid
    work_units.unpaid.inject(0) { |sum, n| sum + n.hours }
  end

  def sum_of_hours_not_invoiced
    work_units.not_invoiced.inject(0) { |sum, n| sum + n.hours }
  end

  def long_name
    "Ticket: [#{id}] - #{project.name} Ticket for #{client.name}"
  end
end
