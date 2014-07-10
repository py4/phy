class Rename < ActiveRecord::Migration
  def change
          rename_column :answers, :exam_answer, :exam_answer_id
  end
end
