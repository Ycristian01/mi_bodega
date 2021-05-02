class RemovePasswordFromAccount < ActiveRecord::Migration[6.1]
  def change
    remove_column :accounts, :password, :string
    remove_column :accounts, :cc_franchise, :string
    add_column :accounts, :plan, :string
  end
end
