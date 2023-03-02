class Post < ApplicationRecord
  before_save :slugify

  belongs_to :user
  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }

  #YouTubeURLを更新する際に、削ぎ落とす前のリンクURLがDBに保存されてしまうため、URLを削ぎ落とす
  #https://qiita.com/TO-TO/items/a81d55908e99ba493d99
  def slugify
    self.url = url.last(11)
  end
end
