class Ticket < ActiveRecord::Base
  acts_as_commentable
  belongs_to :project
  has_many :work_units

  validates_presence_of :project_id
  validates_presence_of :name

  def to_s
    name
  end
end
