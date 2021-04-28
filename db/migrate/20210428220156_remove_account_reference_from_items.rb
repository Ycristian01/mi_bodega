class RemoveAccountReferenceFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_reference :items, :account, index: true, foreign_key: true
  end
end
