class AddSpecialToExams < ActiveRecord::Migration
  def change
    add_column :exams, :special, :boolean, default: false
  end
end
