class CreateChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :choices do |t|
      t.string :body, null: false
      t.boolean :answer, null: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
