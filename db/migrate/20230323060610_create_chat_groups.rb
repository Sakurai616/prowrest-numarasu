class CreateChatGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_groups do |t|
      t.string :image
      t.string :group_name, null: false
      t.text :group_description

      t.timestamps
    end
  end
end
