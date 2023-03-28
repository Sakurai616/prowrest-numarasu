class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_group

  mount_uploader :image, ImageUploader

  validates :body, presence: true, length: { maximum: 65_535 }

  after_create_commit { MessageBroadcastJob.perform_later self }
end
