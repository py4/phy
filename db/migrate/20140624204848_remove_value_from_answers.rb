class RemoveValueFromAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :value, :string
  end
end
