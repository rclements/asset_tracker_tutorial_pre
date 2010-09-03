class Client < ActiveRecord::Base
  has_many :projects
  has_many :tickets, :through => :projects

  validates_presence_of :name
  validates_presence_of :status
  validates_uniqueness_of :name

  def to_s
    name
  end

  def status
    Client.statuses[attributes["status"]]
  end

  def status=(val)
    write_attribute(:status, Client.statuses.invert[val])
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
  end
end
