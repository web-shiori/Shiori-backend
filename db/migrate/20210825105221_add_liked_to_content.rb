class AddLikedToContent < ActiveRecord::Migration[5.2]
  def change
    add_column :content, :liked, :boolean, default: false
  end
end
