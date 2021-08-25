class Folder < ApplicationRecord
  self.table_name = "folder"

  has_many :content_folder
  has_many :content, through: :content_folder

  validates :name, presence: true, length: { maximum: 255 }
end
