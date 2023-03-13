class Question < ApplicationRecord
  belongs_to :user
  has_many :choices, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :sentence, presence: true, length: { maximum: 65_535 }
end
