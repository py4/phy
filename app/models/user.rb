class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :age, presence: true, numericality: true
  validates_inclusion_of :age, :in => 0..99
  
  validates :name, presence: true
  validates :surname, presence: true
  validates :username, presence: true, uniqueness: true
  validates :user_type, presence: true
  validates_inclusion_of :user_type, :in => 0..1

  def customer?
  	user_type == 0
  end

  def adviser?
  	user_type == 1
  end
end
