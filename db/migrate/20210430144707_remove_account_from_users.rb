class RemoveAccountFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :account, index: true
  end
end
