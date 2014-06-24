class AddStatusToExamAnswers < ActiveRecord::Migration
  def change
    add_column :exam_answers, :status, :boolean, default: false
  end
end
