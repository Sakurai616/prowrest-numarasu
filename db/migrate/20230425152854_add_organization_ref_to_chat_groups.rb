class AddOrganizationRefToChatGroups < ActiveRecord::Migration[7.0]
  def change
    add_reference :chat_groups, :organization, null: false, foreign_key: true
  end
end
