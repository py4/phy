class AddExamAnswerIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :exam_answer, :integer
  end
end
