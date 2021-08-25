class ContentFolder < ApplicationRecord
  belongs_to :content
  belongs_to :folder
  validates :content_id, uniqueness: { scope: :folders_id }
end
