class ContentFolder < ApplicationRecord
  self.table_name = "content_folder"

  belongs_to :content, class_name: "Content"
  belongs_to :folder, class_name: "Folder"

  validates :content_id, uniqueness: { scope: :folder_id }
end
