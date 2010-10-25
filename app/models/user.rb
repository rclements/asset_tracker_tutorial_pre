class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :lockable

  acts_as_authorization_subject :association_name => :roles

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :middle_initial

  validates_presence_of :first_name, :last_name, :middle_initial

  has_many :work_units

  # Scopes
  scope :with_unpaid_work_units, joins(:work_units).where(' work_units.paid IS NULL OR work_units.paid = "" ').group('users.id')

  # Return the initials of the User
  def initials
    "#{first_name[0]}#{middle_initial}#{last_name[0]}".upcase
  end

  def time_for(time)
    work_units.scheduled_between(time.beginning_of_day, time.end_of_day)
  end

  def to_s
    "#{first_name} #{middle_initial} #{last_name}"
  end

  def admin?
    has_role?(:admin)
  end

  def locked
    locked_at?
  end

end
