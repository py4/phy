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

  has_many :customers, :class_name => 'User', :foreign_key => 'adviser_id'
  belongs_to :adviser, :class_name => 'User', :foreign_key => 'adviser_id'

  validate :validate_not_having_adviser
  validate :validate_adviser

  before_create :set_user_code

  def customer?
  	user_type == 0
  end

  def adviser?
  	user_type == 1
  end

  def validate_not_having_adviser
    errors.add(:adviser_id, 'Adviser cannot have adviser') if adviser? and adviser_id
  end

  def validate_adviser
    puts adviser_id
    errors.add(:base, 'Custom cannot have customers') if (customer? and adviser_id and User.find(adviser_id).customer?)
  end

  def set_user_code
    user_code = SecureRandom.uuid.split('-').last
  end
end
