class Question < ApplicationRecord
  before_save :slugify

  belongs_to :user
  has_many :choices, dependent: :destroy, inverse_of: :question
  accepts_nested_attributes_for :choices, allow_destroy: true
  belongs_to :organization, optional: true

  mount_uploader :image, ImageUploader

  validates :sentence, presence: true, length: { maximum: 65_535 }

  scope :title_contain, ->(word) { where('title LIKE ?', "%#{word}%") }
  scope :sentence_contain, ->(word) { where('questions.sentence LIKE ?', "%#{word}%") }
  scope :with_organization, ->(organization_name) { joins(:organization).where(organizations: { name: organization_name }) }

  def slugify
    self.url = url.last(11)
  end
end
