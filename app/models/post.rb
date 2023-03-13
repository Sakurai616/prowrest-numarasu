class Post < ApplicationRecord
  before_save :slugify

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }

  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }

  #YouTubeURLを更新する際に、削ぎ落とす前のリンクURLがDBに保存されてしまうため、URLを削ぎ落とす
  #https://qiita.com/TO-TO/items/a81d55908e99ba493d99
  def slugify
    self.url = url.last(11)
  end

  def liked_by?(user)
    liking_users.include?(user)
  end

  def save_with_tags(tag_names:)
    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def tag_names
    # NOTE: pluckだと新規作成失敗時に値が残らない(返り値がnilになる)
    tags.map(&:name).join(',')
  end
end
