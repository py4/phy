class AddChoiceIndexToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :choice_index, :integer
  end
end
