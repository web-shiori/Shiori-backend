class CreateContentToFolder < ActiveRecord::Migration[5.2]
  def change
    create_table :content_folders do |t|
      t.references :folders, foreign_key: true
      t.references :content, foreign_key: { to_table: 'content' }

      t.timestamp
    end
  end
end
