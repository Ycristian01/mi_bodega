class RemoveAccountFromItem < ActiveRecord::Migration[6.1]
  def change
    remove_reference :items, :accounts, null: false, foreign_key: true
  end
end
