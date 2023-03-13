class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.string :image
      t.string :url
      t.text :sentence, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
