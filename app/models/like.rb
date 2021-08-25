class Like < ApplicationRecord
  belongs_to :user
  belongs_to :content
  validates :content_id, uniqueness: { scope: :content_id }
end
