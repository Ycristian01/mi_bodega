class RemoveAccountReferenceFromItem < ActiveRecord::Migration[6.1]
  def change
    remove_reference :items, :accounts
  end
end
