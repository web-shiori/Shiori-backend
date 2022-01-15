class AddOffsetWidthAndHeightToContent < ActiveRecord::Migration[5.2]
  def change
    add_column :content, :offsetWidth, :integer
    add_column :content, :offsetHeight, :integer
  end
end
