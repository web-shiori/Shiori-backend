class Content < ApplicationRecord
  belongs_to :user

  validates :user_id, presense: true
  validates :title, presense: true, length: { maximum: 255 }
  validates :url, presense: true
  validates :sharing_url, presense: true

end
