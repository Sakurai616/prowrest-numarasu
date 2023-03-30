class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_group

  validates :body, presence: true, length: { maximum: 65_535 }

  after_create_commit { MessageBroadcastJob.perform_later self }
end
