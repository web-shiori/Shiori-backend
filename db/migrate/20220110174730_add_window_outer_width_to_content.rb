class AddWindowOuterWidthToContent < ActiveRecord::Migration[5.2]
  def change
    add_column :content, :window_outer_width, :integer
    add_column :content, :window_outer_height, :integer
  end
end
