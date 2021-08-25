class RenameFoldersToFolder < ActiveRecord::Migration[5.2]
  def change
    rename_table :folders, :folder
  end
end
