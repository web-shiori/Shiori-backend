class Content < ApplicationRecord
  self.table_name = "content"
  paginates_per 50

  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :url, presence: true
  validates :sharing_url, presence: true

end
