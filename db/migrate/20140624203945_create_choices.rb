class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.references :exam, index: true

      t.timestamps
    end
  end
end
