class AddContentToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :content, :string
  end
end
