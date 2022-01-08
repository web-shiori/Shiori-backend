class AddPdfPageNumToContent < ActiveRecord::Migration[5.2]
  def change
    add_column :content, :pdf_page_num, :integer, default: 0
  end
end
