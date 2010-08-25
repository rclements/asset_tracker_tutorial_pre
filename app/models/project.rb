class Project < ActiveRecord::Base
  belongs_to :client
  validates_presence_of :name
  validates_presence_of :client_id
  validates_uniqueness_of :name, :scope => :client_id

  def to_s
    name
  end
end
