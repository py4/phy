class AddScoreToExamAnswers < ActiveRecord::Migration
  def change
    add_column :exam_answers, :score, :integer
  end
end
