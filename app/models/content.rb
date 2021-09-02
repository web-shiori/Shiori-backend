class Content < ApplicationRecord
  self.table_name = "content"
  paginates_per 50

  belongs_to :user
  has_many :content_folder
  has_many :folder, through: :content_folder

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :url, presence: true
  validates :sharing_url, presence: true

  before_validation :set_sharing_url
  before_save :set_thumbnail_img_url
  before_save :set_content_type

  scope :search, ->(q) {
    where('LOWER(title) LIKE ?', "%#{q}%") unless q.blank?
  }

  # シェア用のURLを追加する
  private def set_sharing_url
    # TODO: シェア用のURLを生成する。暫定でurlをそのまま入れる
    self.sharing_url = self.url
  end

  # サムネイル画像がない場合はサムネイル画像のURLを設定する
  private def set_thumbnail_img_url
    default_thumbnail_img_url = "https://i.gyazo.com/826e6fcc8ff7620246066acd1bb40cc6.png"
    self.thumbnail_img_url = default_thumbnail_img_url if self.thumbnail_img_url.nil?
  end

  # コンテンツのタイプを設定する
  private def set_content_type
    self.content_type =
      if self.video_playback_position != 0
        "video"
      elsif self.file_url != nil
        "file"
      else
        "web"
      end
  end

end
