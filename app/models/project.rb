class Project < ActiveRecord::Base
  acts_as_commentable
  belongs_to :client
  has_many :tickets

  validates_presence_of :name
  validates_presence_of :client_id
  validates_uniqueness_of :name, :scope => :client_id

  def to_s
    name
  end
end
