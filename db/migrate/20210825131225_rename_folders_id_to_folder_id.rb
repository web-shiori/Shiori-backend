class RenameFoldersIdToFolderId < ActiveRecord::Migration[5.2]
  def change
    rename_column :content_folder, :folders_id, :folder_id
  end
end
