class AddContentTypeToContent < ActiveRecord::Migration[5.2]
  def change
    add_column :content, :content_type, :string
  end
end
