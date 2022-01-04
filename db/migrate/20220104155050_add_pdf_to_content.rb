class AddPdfToContent < ActiveRecord::Migration[5.2]
  def change
    add_column :content, :pdf, :string
  end
end
