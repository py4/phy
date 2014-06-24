class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :exam, index: true
      t.string :content
      t.timestamps
    end
  end
end
