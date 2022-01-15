class ChangeWindowOuterWidth < ActiveRecord::Migration[5.2]
  def change
    rename_column :content, :offsetWidth, :offset_width
    rename_column :content, :offsetHeight, :offset_height
  end
end
