class RemoveBoxesFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_reference :items, :boxes, index: true, foreign_key: true
  end
end
