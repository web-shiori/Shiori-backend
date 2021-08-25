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

  # シェア用のURLを追加する
  private def set_sharing_url
    # TODO: シェア用のURLを生成する。暫定でurlをそのまま入れる
    self.sharing_url = self.url
  end

  # サムネイル画像のURLを設定する
  private def set_thumbnail_img_url
    # TODO: サムネイルurlをコンテンツのサイトから取得する。暫定でにぶちゃんの画像を入れる
    # NOTE: 非同期的にやる。デフォルトでセットする画像も準備しておく
    self.thumbnail_img_url = "https://i.ytimg.com/vi/xP_Ovd8-GM8/maxresdefault.jpg"
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
