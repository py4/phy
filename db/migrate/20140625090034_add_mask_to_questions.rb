class AddMaskToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :mask, :string
  end
end
