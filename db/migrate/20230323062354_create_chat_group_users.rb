class CreateChatGroupUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_group_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
