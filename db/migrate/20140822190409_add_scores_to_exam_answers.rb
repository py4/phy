class AddScoresToExamAnswers < ActiveRecord::Migration
  def change
    add_column :exam_answers, :scores, :hstore
  end
end
