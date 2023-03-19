class Question < ApplicationRecord
  before_save :slugify

  belongs_to :user
  has_many :choices, dependent: :destroy, inverse_of: :question
  accepts_nested_attributes_for :choices, allow_destroy: true

  mount_uploader :image, ImageUploader
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :sentence, presence: true, length: { maximum: 65_535 }

  def slugify
    self.url = url.last(11)
  end
end
