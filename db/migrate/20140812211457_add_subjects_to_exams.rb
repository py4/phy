class AddSubjectsToExams < ActiveRecord::Migration
  def change
    add_column :exams, :subject, :hstore
    add_hstore_index :exams, :subject
  end
end
