class Folder < ApplicationRecord
  has_many :contents, through: :content_folders

  validates :name, presence: true, length: { maximum: 255 }
end
