class AddAndRemoveFieldsOfAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :stripe_customer_id, :string
    add_column :accounts, :card_number, :string
    add_column :accounts, :card_expires, :string
    add_column :accounts, :cvc, :string
  end
end
