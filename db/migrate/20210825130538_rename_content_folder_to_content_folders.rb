class RenameContentFolderToContentFolders < ActiveRecord::Migration[5.2]
  def change
    rename_table :content_folders, :content_folder
  end
end
