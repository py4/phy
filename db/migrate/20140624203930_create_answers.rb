class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :value
      t.references :question, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
