class AddUserIdToContent < ActiveRecord::Migration[5.2]
  def change
    add_reference :content, :user, foreign_key: true

    add_index :content, %i[id user_id]
  end
end
