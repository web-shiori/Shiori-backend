class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  devise :omniauthable
  has_many :content, dependent: :destroy
  has_many :folder, dependent: :destroy

  after_create :add_initial_content

  def self.find_for_oauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  private
  def self.dummy_email(auth)
    "#{auth.uid}@#{auth.provider}.com"
  end

  private def add_initial_content
    describe_scroll_function_content_params = {
      title: "アプリの使い方(1) スクロール位置保存・復旧",
      url: "https://www.youtube.com/watch?v=TzCfDE0Fd7Q&ab_channel=mgwg.pmpwtggw",
      thumbnail_img_url: "https://img.youtube.com/vi/TzCfDE0Fd7Q/0.jpg",
      video_playback_position: 0,
      scroll_position_x: 0,
      scroll_position_y: 0,
      max_scroll_position_x: 0,
      max_scroll_position_y: 0
    }
    describe_video_playback_position_function_content_params = {
      title: "アプリの使い方(2) 動画再生位置保存・復旧",
      url: "https://www.youtube.com/watch?v=MJdtMNIT8Qo&ab_channel=mgwg.pmpwtggw",
      thumbnail_img_url: "https://img.youtube.com/vi/MJdtMNIT8Qo/0.jpg",
      video_playback_position: 0,
      scroll_position_x: 0,
      scroll_position_y: 0,
      max_scroll_position_x: 0,
      max_scroll_position_y: 0
    }
    describe_data_migration_content_params = {
      title: "データ移行の手順(v2以前からのユーザー様向け)",
      url: "https://web-shiori.github.io/Shiori-iOS/Usage/data-migration",
      thumbnail_img_url: "https://github.com/web-shiori/Shiori-chrome-extension/blob/main/doc/shiori.png?raw=true",
      video_playback_position: 0,
      scroll_position_x: 0,
      scroll_position_y: 0,
      max_scroll_position_x: 0,
      max_scroll_position_y: 0
    }
    self.content.create(describe_data_migration_content_params)
    self.content.create(describe_video_playback_position_function_content_params)
    self.content.create(describe_scroll_function_content_params)
  end
end
