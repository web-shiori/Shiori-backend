class AddTypeToContent < ActiveRecord::Migration[5.2]
  def change
    add_column :content, :type, :string
  end
end
