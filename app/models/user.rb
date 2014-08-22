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
  has_many :answers, dependent: :destroy
  has_many :exam_answers, dependent: :destroy
  has_many :task_statuses, dependent: :destroy
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
    self.adviser_message = I18n.t(:default_message)
    self.status = 0
    self.user_code = SecureRandom.uuid.split('-').last
  end

  def create_task_statuses
    puts ">>>>>>>>> creating task status <<<<<<<<<<<"
    Task.all.each do |task|
      task.task_statuses.create! value: false, user_id: self.id
    end
  end

  def get_unrolled_exams
    names = []
    exam_answers.includes(:exam).each do |answer|
      names << answer.exam.name
    end
    return Exam.pluck(:name) - names
  end

  def get_hash exam_answer
    best_key = nil
    best_value = 0

    exam_answer.scores.each do |key,value|
      if value.to_i > best_value
        best_key = key
        best_value = value.to_i
      end
    end

    return JOBS[best_key]
  end
end
