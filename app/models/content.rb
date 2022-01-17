class Content < ApplicationRecord
  self.table_name = "content"
  paginates_per 50

  belongs_to :user
  has_many :content_folder, dependent: :destroy
  has_many :folder, through: :content_folder

  mount_uploader :pdf, PdfUploader

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :url, presence: true
  validates :sharing_url, presence: true
  validate  :pdf_size

  before_validation :set_sharing_url
  before_save :set_thumbnail_img_url
  before_create :set_content_type
  before_create :set_video_sharing_url

  scope :search, ->(q) {
    where('LOWER(title) LIKE ?', "%#{q}%") unless q.blank?
  }

  # シェア用のURLを追加する
  private def set_sharing_url
    self.sharing_url =
      if self.content_type == "pdf"
        "#{self.url}\#page=#{self.pdf_page_num}"
      else
        self.url
      end
  end

  private def set_video_sharing_url
    return unless self.content_type == "video"
    if self.url.match(/youtube/)
      video_id = self.url.split('v=')[1]
      unless video_id.blank?
        ampersandPosition = video_id.index('&')
        if ampersandPosition && ampersandPosition != -1
          video_id = video_id.slice(0..ampersandPosition)
        end
        self.sharing_url = "https://youtu.be/#{video_id}?t=#{self.video_playback_position}";
      end
    elsif self.url.match(/pornhub/)
      self.sharing_url = "#{url}&t=#{self.video_playback_position}"
    elsif self.url.match(/tube8/) || self.url.match(/redtube/) || self.url.match(/xhamster/) || self.url.match(/www.openrec.tv/)
      self.sharing_url = "#{url}?t=#{self.video_playback_position}"
    elsif self.url.match(/nicovideo/)
      self.sharing_url = "#{url}?from=#{self.video_playback_position}"
    elsif self.url.match(/dailymotion/)
      self.sharing_url = "#{url}?start=#{self.video_playback_position}"
    elsif self.url.match(/twitch/)
      h = (self.video_playback_position / 3600).floor
      m = ((self.video_playback_position % 3600) / 60).floor
      s = self.video_playback_position % 60
      self.sharing_url = "#{url}?t=#{h}h#{m}m#{s}s"
    end
  end

  # サムネイル画像がない場合はサムネイル画像のURLを設定する
  private def set_thumbnail_img_url
    default_thumbnail_img_url = "https://i.gyazo.com/826e6fcc8ff7620246066acd1bb40cc6.png"
    self.thumbnail_img_url = default_thumbnail_img_url if self.thumbnail_img_url.nil?
  end

  # コンテンツのタイプを設定する
  private def set_content_type
    return if self.content_type
    self.content_type =
      if self.pdf.url || self.pdf_page_num != 0
        "pdf"
      elsif self.video_playback_position && self.video_playback_position != 0
        "video"
      elsif self.audio_playback_position && self.audio_playback_position != 0
        "audio"
      elsif self.file_url != nil
        "file"
      else
        "web"
      end
  end

  # アップロードされたPDFのスクリーンショットのサイズをバリデーションする
  private def pdf_size
    if pdf.size > 10.megabytes
      errors.add(:pdf, "should be less than 10MB")
    end
  end
end
