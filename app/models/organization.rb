class Organization < ApplicationRecord
  has_many :posts, inverse_of: :organization
  has_many :questions, inverse_of: :organization
  has_many :chat_groups, inverse_of: :organization

  validates :name, presence: true
end
