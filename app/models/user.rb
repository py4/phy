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

  has_many :applicants, :class_name => 'User', :foreign_key => 'adviser_id'
  has_many :answers
  has_many :exam_answers
  has_many :task_statuses
  belongs_to :adviser, :class_name => 'User', :foreign_key => 'adviser_id'

  validate :validate_not_having_adviser
  validate :validate_adviser

  before_create :set_user_code
  after_create :create_task_statuses

  def applicant?
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
    errors.add(:base, 'Applicant cannot have applicants') if (applicant? and adviser_id and User.find(adviser_id).applicant?)
  end

  def set_user_code
    self.status = 0
    self.user_code = SecureRandom.uuid.split('-').last
  end

  def create_task_statuses
    puts ">>>>>>>>> creating task status <<<<<<<<<<<"
    Task.all.each do |task|
      task.task_statuses.create! value: false, user_id: self.id
    end
  end
end
