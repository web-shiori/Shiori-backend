class AddLambdaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lambda, :boolean, default: false
  end
end
