class CreateExamAnswers < ActiveRecord::Migration
  def change
    create_table :exam_answers do |t|
      t.references :exam, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
