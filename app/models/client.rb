class Client < ActiveRecord::Base
  include GuidReferenced
  acts_as_commentable
  has_many :projects
  has_many :tickets, :through => :projects
  has_many :comments, :as => :commentable
  has_many :file_attachments
  has_many :contacts

  validates_presence_of :name
  validates_presence_of :status
  validates_uniqueness_of :name, :allow_nil => false

  def total_tickets
    projects.inject(0) {|sum, p| sum + p.tickets.count }
  end

  def total_hours
    projects.inject(0){|sum, p| sum + p.hours}
  end

  def uninvoiced_hours
    WorkUnit.for_client(self).not_invoiced.inject(0) {|sum, w| sum + w.hours}
  end

  def to_s
    name
  end

  def status
    Client.statuses[attributes["status"]]
  end

  def status=(val)
    write_attribute(:status, Client.statuses.invert[val])
  end

  def allows_access?(user)
    projects.any? {|p| p.accepts_roles_by?(user)} || user.admin?
  end

  class << self
    def statuses
      {
        "10" => "Active",
        "20" => "Suspended",
        "30" => "Inactive",
      }
    end

    def for(projects_or_tickets_or_work_units)
      projects_or_tickets_or_work_units.collect{ |resource| resource.client }.uniq
    end

    def for_user(user)
      select {|c| c.allows_access?(user) }
    end
  end

end
