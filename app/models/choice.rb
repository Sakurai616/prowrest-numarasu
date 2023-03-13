class Choice < ApplicationRecord
  belongs_to :question

  validates :body, presence: true, length: { maximum: 255 }
  validates :answer, presence: true
end
