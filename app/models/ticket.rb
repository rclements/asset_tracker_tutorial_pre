class Ticket < ActiveRecord::Base
  include GuidReferenced
  acts_as_commentable
  belongs_to :project
  has_many :work_units
  has_many :file_attachments

  validates_presence_of :project_id
  validates_presence_of :name

  def self.for_user(user)
    select {|t| t.allows_access?(user) }
  end

  def client
    project.client
  end

  def to_s
    name
  end

  def unpaid_hours
    work_units.unpaid.inject(0) { |sum, n| sum + n.hours }
  end

  def uninvoiced_hours
    work_units.not_invoiced.inject(0) { |sum, n| sum + n.hours }
  end

  def long_name
    "Ticket: [#{id}] - #{project.name} - #{name} ticket for #{client.name}"
  end

  def allows_access?(user)
    project.accepts_roles_by?(user) || user.admin?
  end

  def hours
    work_units.inject(0) {|sum, w| sum + w.hours}
  end

end
