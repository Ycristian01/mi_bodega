class AddBoxToItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :items, :boxes, null: false, foreign_key: true
  end
end
