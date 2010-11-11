class Project < ActiveRecord::Base
  include GuidReferenced
  acts_as_commentable
  belongs_to :client
  has_many :tickets
  has_many :comments, :as => :commentable
  has_many :file_attachments

  validates_presence_of :name
  validates_presence_of :client_id
  validates_uniqueness_of :name, :scope => :client_id

  def hours
    tickets.inject(0) do |sum, ticket|
      sum + ticket.work_units.inject(0) do |sum, work_unit|
        sum + work_unit.hours
      end
    end
  end

  def to_s
    name
  end
end
