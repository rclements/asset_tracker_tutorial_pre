class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :middle_initial

  validates_presence_of :first_name, :last_name, :middle_initial

  has_many :work_units

  # Return the initials of the User
  def initials
    "#{first_name[0]}#{middle_initial}#{last_name[0]}".upcase
  end
end
