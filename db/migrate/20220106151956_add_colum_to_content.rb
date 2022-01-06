class AddColumToContent < ActiveRecord::Migration[5.2]
  def change
    add_column :content, :device, :string
    add_column :content, :user_agent, :string
    add_column :content, :browser, :string
    add_column :content, :window_inner_width, :integer
    add_column :content, :window_inner_height, :integer
  end
end
