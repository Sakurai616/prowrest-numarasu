class AddOrganizationRefToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :organization, null: false, foreign_key: true
  end
end
