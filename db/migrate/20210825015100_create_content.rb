class CreateContent < ActiveRecord::Migration[5.2]
  def change
    create_table :content do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :sharing_url, null: false
      t.string :file_url
      t.string :thumbnail_img_url
      t.integer :scroll_position_x
      t.integer :scroll_position_y
      t.integer :max_scroll_position_x
      t.integer :max_scroll_position_y
      t.integer :video_playback_position
      t.string :specified_text
      t.string :specified_dom_id
      t.string :specified_dom_class
      t.string :specified_dom_tag
      t.boolean :delete_flag, null: false, default: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
