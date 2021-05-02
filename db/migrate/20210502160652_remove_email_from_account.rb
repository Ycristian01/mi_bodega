class RemoveEmailFromAccount < ActiveRecord::Migration[6.1]
  def change
    remove_column :accounts, :email, :string
  end
end
