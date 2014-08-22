class ExamAnswer < ActiveRecord::Base
  belongs_to :exam
  belongs_to :user
  has_many :answers, dependent: :destroy
  store_accessor :scores

  after_create :set_scores

  def set_scores
  	update_attributes scores: {}
  end


  def get_score keys
  	puts "keys: #{keys}"
  	score = 0
  	ans = answers.includes(:question)
  	puts "ans size: #{ans.size}"
  	keys.each do |i|
  		splitted = ans[i].question.mask.split('')
  		puts "splitted: #{splitted}"
  		score += splitted[ans[i].choice_index.to_i].to_i
  	end
  	return score
  end
end
