class Client < ActiveRecord::Base
  has_many :projects
  validates_presence_of :name
  validates_presence_of :status
  validates_uniqueness_of :name

  def to_s
    name
  end
end
