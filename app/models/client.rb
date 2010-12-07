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
        "1" => "Good",
        "2" => "Bad",
        "3" => "Ugly",
        "4" => "ANGRY"
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
