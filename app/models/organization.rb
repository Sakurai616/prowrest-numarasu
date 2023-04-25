class Organization < ApplicationRecord
  has_many :posts, inverse_of: :organization

  validates :name, presence: true
end
