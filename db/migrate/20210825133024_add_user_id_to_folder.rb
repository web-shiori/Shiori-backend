class AddUserIdToFolder < ActiveRecord::Migration[5.2]
  def change
    add_reference :folder, :user, foreign_key: true

    add_index :folder, %i[id user_id]
  end
end
