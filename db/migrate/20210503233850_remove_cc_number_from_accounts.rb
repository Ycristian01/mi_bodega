class RemoveCcNumberFromAccounts < ActiveRecord::Migration[6.1]
  def change
    remove_column :accounts, :cc_number, :string
  end
end
