class AddUsingByToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :using_by, :integer
    add_column :boxes, :qr_code, :text
  end
end
