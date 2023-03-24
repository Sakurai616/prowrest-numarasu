class ChatGroup < ApplicationRecord
  has_many :chat_group_users, dependent: :destroy
  has_many :users, through: :chat_group_users
  has_many :messages, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :group_name, presence: true, length: { maximum: 255 }
end
