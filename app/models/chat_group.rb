class ChatGroup < ApplicationRecord
  has_many :chat_group_users, dependent: :destroy
  has_many :users, through: :chat_group_users, source: :user
  has_many :messages, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :group_name, presence: true, length: { maximum: 255 }

  scope :group_name_contain, ->(word) { where('group_name LIKE ?', "%#{word}%") }
  scope :group_description_contain, ->(word) { where('chat_groups.group_description LIKE ?', "%#{word}%") }
end
